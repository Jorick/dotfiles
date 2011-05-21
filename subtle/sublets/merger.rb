#!/usr/bin/ruby
#
# @file Merger
#
# @copyright (c) 2011, Christoph Kappel <unexist@dorfelite.net>
# @version $Id: ruby/merger.rb,v 92 2011/04/25 11:33:16 unexist $
#
# This program can be distributed under the terms of the GNU GPLv2.
# See the file COPYING for details.
#
# Merge tags of current and selected views temporarily.
#
# Colors:
#
# Focus    - Currently selected view
# View     - Other views
# Occupied - Views client is visibl
# Urgent   - Selected views for merge
#
# Keys:
#
# Left, Up    - Move to left
# Right, Down - Move to right
# Escape      - Hide/exit
# Space       - Select view
# Return      - Merge selected views and exit hide/exit
#
# http://subforge.org/projects/subtle-contrib/wiki/Merger
#

require "singleton"

begin
  require "subtle/subtlext"
rescue LoadError
  puts ">>> ERROR: Couldn't find subtlext"
  exit
end

# Check for subtlext version
major, minor, teeny = Subtlext::VERSION.split(".").map(&:to_i)
if(major == 0 and minor == 9 and 2602 > teeny)
  puts ">>> ERROR: merger needs at least subtle `0.9.2602' (found: %s)" % [
    Subtlext::VERSION
   ]
  exit
end

# Launcher class
module Subtle # {{{
  module Contrib # {{{
    class Merger # {{{
      include Singleton

      # Default values
      @@font = "-*-*-medium-*-*-*-14-*-*-*-*-*-*-*"

      # Singleton methods

      ## fonts {{{
      # Set font strings
      # @param [String]  fonts  Fonts array
      ##

      def self.font=(font)
        @@font = font
      end # }}}

      ## run {{{
      # Run expose
      ##

      def self.run
        self.instance.run
      end # }}}

      # Instance methods

      ## initialize {{{
      # Create expose instance
      ##

      def initialize
        # Values
        @colors   = Subtlext::Subtle.colors
        @wins     = []
        @merged   = {}
        @backup   = {}
        @x        = 0
        @y        = 0
        @width    = 0
        @height   = 0

        # Create main window
        @win = Subtlext::Window.new(:x => 0, :y => 0, :width => 1, :height => 1) do |w|
          w.name        = "Merger"
          w.font        = @@font
          w.foreground  = @colors[:title_fg]
          w.background  = @colors[:title_bg]
          w.border_size = 0
        end

        # Font metrics
        @font_height = @win.font_height + 6
        @font_y      = @win.font_y
      end # }}}

      ## run {{{
      # Show and run launcher
      ##

      def run
        update
        arrange
        recolor
        show

        # Listen to key press events
        @win.listen do |key|
          ret = true

          case key
            when :left, :up # {{{
              idx       = @views.index(@selected)
              idx      -= 1 if(1 < idx)
              @selected  = @views[idx]

              recolor # }}}
            when :right, :down # {{{
              idx       = @views.index(@selected)
              idx      += 1 if(idx < (@views.size - 1))
              @selected  = @views[idx]

              recolor # }}}
            when :space # {{{
              if(@merged[@current.name].include?(@selected))
                @merged[@current.name].delete(@selected)
              else
                @merged[@current.name] << @selected
              end
              recolor # }}}
            when :return # {{{
              # Restore tags or update
              if(@merged[@current.name].empty?)
                @merged.delete(@current.name)
                @current.tags = @backup[@current.name]
              else
                @current.tags = @merged[@current.name].inject(@backup[@current.name]) { |r, v| r | v.tags }

                # Update
              end

              ret = false # }}}
            when :escape # {{{
              @merged.delete(@current.name)
              ret = false # }}}
          end

          ret
        end

        hide
      end # }}}

      private

      ## update # {{{
      # Update clients and windows
      ##

      def update
        @current  = Subtlext::View.current
        @views    = Subtlext::View.all.select { |v| v != @current }
        @selected = @views.first
        @views.unshift(@current)

        # Backup tags of current view
        unless(@backup.keys.include?(@current.name))
          @backup[@current.name] = @current.tags
        end

        # Create empty array
        unless(@merged.keys.include?(@current.name))
          @merged[@current.name] = []
        end

        # Check window count
        if(@views.size > @wins.size)
          (@views.size - @wins.size).times do |i|
            @wins << @win.subwindow(:x => 0, :y => 0, :width => 1, :height => 1) do |w|
              w.name       = "Merger client"
              w.font       = @@font
              w.foreground = @colors[:views_fg]
              w.background = @colors[:views_bg]
              w.border_size = 0
            end
          end
        end
      end # }}}

      ## arrange {{{
      # Arrange window and subwindows
      ##

      def arrange
        geo     = Subtlext::Screen.current.geometry
        @width  = geo.width * 50 / 100 #< Max width
        @height = @font_height
        wx      = 0
        wy      = 0
        len     = 0
        wwidth  = 0

        # Arrange client windows
        @views.each_with_index do |v, i|
          w   = @wins[i]
          len = w.write(6, @font_y + 3, v.name) + 6

          # Wrap lines
          if(wx + len > @width)
            wwidth  = wx if(wx > wwidth)
            wx      = 0
            wy     += @font_height
          end

          w.geometry = [ wx, wy, len, @font_height ]

          wx += len
        end

        # Update geometries
        @width   = 0 == wwidth ? wx : wwidth
        @height += wy
        @x       = geo.x + ((geo.width - @width) / 2)
        @y       = geo.y + ((geo.height - @height) / 2)

        @win.geometry = [ @x , @y, @width, @height ]
      end # }}}

      ## recolor {{{
      # Update colors of subwindows
      ##

      def recolor
        @wins.each_with_index do |w, i|
          if(@views[i] == @selected)
            w.foreground = @colors[:focus_fg]
            w.background = @colors[:focus_bg]
          elsif(@views[i] == @current)
            w.foreground = @colors[:occupied_fg]
            w.background = @colors[:occupied_bg]
          else
            w.foreground = @colors[:views_fg]
            w.background = @colors[:views_bg]
          end

          if(@merged[@current.name].include?(@views[i]))
            w.foreground = @colors[:urgent_fg]
          end

          w.redraw
        end
      end # }}}

      ## show {{{
      # Show launcher
      ##

      def show
        @win.show

        # Show used windows only
        @wins.each_with_index do |w, i|
          w.show if(i < @views.size)
        end
      end # }}}

      ## hide # {{{
      # Hide launcher
      ##

      def hide
        @win.hide
        @wins.map(&:hide)
      end # }}}

    end # }}}
  end # }}}
end # }}}

# Implicitly run
if(__FILE__ == $0)
  # Set font
  #Subtle::Contrib::Merger.font =
  # "xft:DejaVu Sans Mono:pixelsize=80:antialias=true"

  Subtle::Contrib::Merger.run
end

# vim:ts=2:bs=2:sw=2:et:fdm=marker
