#!/usr/bin/ruby
#
# @file Positioner
#
# @copyright (c) 2011, Christoph Kappel <unexist@dorfelite.net>
# @version $Id: ruby/positioner.rb,v 92 2011/04/25 11:33:16 unexist $
#
# This program can be distributed under the terms of the GNU GPLv2.
# See the file COPYING for details.
#
# Select and tag/untag visible views of current client window
#
# Colors:
#
# Focus    - Currently selected view
# View     - Other views
# Occupied - Views client is visible
# Urgent   - Selected views
#
# Keys:
#
# Left, Up    - Move to left
# Right, Down - Move to right
# Escape      - Hide/exit
# Space       - Select view
# Return      - Tag/untag selected views and exit hide/exit
#
# http://subforge.org/projects/subtle-contrib/wiki/Positioner
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

# Positioner class
module Subtle # {{{
  module Contrib # {{{
    class Positioner # {{{
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
        @colors = Subtlext::Subtle.colors
        @wins   = []

        # Create main window
        @win = Subtlext::Window.new(:x => 0, :y => 0, :width => 1, :height => 1) do |w|
          w.name        = "Positioner"
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
      # Show and run positioner
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
              idx       = @views.index(@cur_sel)
              idx      -= 1 if(0 < idx)
              @cur_sel  = @views[idx]

              recolor # }}}
            when :right, :down # {{{
              idx       = @views.index(@cur_sel)
              idx      += 1 if(idx < (@views.size - 1))
              @cur_sel  = @views[idx]

              recolor # }}}
            when :space # {{{
              if(@selected.include?(@cur_sel))
                @selected.delete(@cur_sel)
              else
                @selected << @cur_sel
              end
              recolor # }}}
            when :return # {{{
              tags = @cur_client.tags

              @selected.each do |sel|
                # Untag or tag
                if(@cur_views.include?(sel))
                  # Remove common tags
                  tags -= (@cur_client.tags - sel.tags)
                else
                  # Find or create tag
                  tag = Subtlext::Tag[sel.name] || Subtlext::Tag.new(sel.name)
                  tag.save

                  tags << tag
                end
              end

              @cur_client.tags = tags

              ret = false # }}}
            when :escape # {{{
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
        @views      = Subtlext::View.all
        @selected   = []
        @cur_client = Subtlext::Client.current
        @cur_views  = @cur_client.views
        @cur_sel    = Subtlext::View.current

        # Check window count
        if(@views.size > @wins.size)
          (@views.size - @wins.size).times do |i|
            @wins << @win.subwindow(:x => 0, :y => 0, :width => 1, :height => 1) do |w|
              w.name       = "Positioner window"
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
        geo     = @cur_client.geometry
        width   = geo.width #< Max width
        height  = @font_height
        wx      = 0
        wy      = 0
        len     = 0
        wwidth  = 0

        # Arrange client windows
        @views.each_with_index do |v, i|
          w   = @wins[i]
          len = w.write(6, @font_y + 3, v.name) + 6

          # Wrap lines
          if(wx + len > width)
            wwidth  = wx if(wx > wwidth)
            wx      = 0
            wy     += @font_height
          end

          w.geometry = [ wx, wy, len, @font_height ]

          wx += len
        end

        # Update geometry
        width   = 0 == wwidth ? wx : wwidth
        height += wy
        x       = geo.x + ((geo.width - width) / 2)
        y       = geo.y + ((geo.height - height) / 2)

        @win.geometry = [ x , y, width, height ]
      end # }}}

      ## recolor {{{
      # Update colors of subwindows
      ##

      def recolor
        @wins.each_with_index do |w, i|
          if(@views[i] == @cur_sel)
            w.foreground = @colors[:focus_fg]
            w.background = @colors[:focus_bg]
          elsif(@cur_views.include?(@views[i]))
            w.foreground = @colors[:occupied_fg]
            w.background = @colors[:occupied_bg]
          else
            w.foreground = @colors[:views_fg]
            w.background = @colors[:views_bg]
          end

          if(@selected.include?(@views[i]))
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

  Subtle::Contrib::Positioner.run
end

# vim:ts=2:bs=2:sw=2:et:fdm=marker
