#!/usr/bin/ruby
#
# @file Selector
#
# @copyright (c) 2011, Christoph Kappel <unexist@dorfelite.net>
# @version $Id: ruby/selector.rb,v 92 2011/04/25 11:33:16 unexist $
#
# Client selector that works like the subscription selector in google reader.
#
# Colors:
#
# Focus    - Currently selected client
# Occupied - Visible clients on current views
# View     - Currently not visible clients
#
# Keys:
#
# Left, Up          - Move to left
# Right, Down       - Move to right
# Tab               - Cycle through windows/matches
# Escape            - Leave input mode/exit selector
# Return            - Focus currently selected and hide/exit selector
# Any capital/digit - Select client prefixed with capital letter/digit
# Any text          - Select client with matching instance name
#
# http://subforge.org/projects/subtle-contrib/wiki/Selector
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
if(major == 0 and minor == 9 and 2577 > teeny)
  puts ">>> ERROR: selector needs at least subtle `0.9.2577' (found: %s)" % [
    Subtlext::VERSION
   ]
  exit
end

# Launcher class
module Subtle # {{{
  module Contrib # {{{
    class Selector # {{{
      include Singleton

      # Prefix letters
      LETTERS = ((49..57).to_a|(65..89).to_a).map(&:chr)

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
        @expanded = false
        @buffer   = ""
        @x        = 0
        @y        = 0
        @width    = 0
        @height   = 0

        # Create main window
        @win = Subtlext::Window.new(:x => 0, :y => 0, :width => 1, :height => 1) do |w|
          w.name        = "Selector"
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

        @buffer = ""

        # Listen to key press events
        @win.listen do |key|
          ret = true

          case key
            when :left, :up # {{{
              idx       = @clients.index(@current)
              idx      -= 1 if(0 < idx)
              @current  = @clients[idx]

              recolor # }}}
            when :right, :down # {{{
              idx       = @clients.index(@current)
              idx      += 1 if(idx < (@clients.size - 1))
              @current  = @clients[idx]

              recolor # }}}
            when :return # {{{
              @current.focus

              ret = false # }}}
            when :escape # {{{
              if(@expanded)
                @buffer = ""
                expand
              else
                ret = false
              end # }}}
            when :backspace # {{{
              if(@expanded)
                @buffer.chop!
                @win.write(2, @height - @font_height + @font_y + 3, "Input: %s" % [ @buffer ])
                @win.redraw
                expand
              end # }}}
            when :tab # {{{
              if(@buffer.empty?)
                clients = @clients
              else
                # Select matching clients
                clients = @clients.select do |c|
                  c.instance.downcase.start_with?(@buffer)
                end
              end

              unless((idx = clients.index(@current)).nil?)
                # Cycle between clients
                if(idx < (clients.size - 1))
                  idx += 1
                else
                  idx = 0
                end

                @current = clients[idx]

                recolor
              end # }}}
            else
              str = key.to_s

              if(!(idx = LETTERS.index(str)).nil? and idx < @clients.size)
                @clients[idx].focus

                ret = false
              elsif(!str.empty?)
                @buffer << str.downcase

                @clients.each do |c|
                  if(c.instance.downcase.start_with?(@buffer))
                    @current = c
                    recolor

                    break
                  end
                end

                expand
                @win.write(6, @height - @font_height + @font_y + 3, "Input: %s" % [ @buffer ])
                @win.redraw
              end
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
        @clients = Subtlext::Client.all
        @visible = Subtlext::Client.visible
        @current = Subtlext::Client.current

        # Check window count
        if(@clients.size > @wins.size)
          (@clients.size - @wins.size).times do |i|
            @wins << @win.subwindow(:x => 0, :y => 0, :width => 1, :height => 1) do |w|
              w.name        = "Selector client"
              w.font        = @@font
              w.foreground  = @colors[:views_fg]
              w.background  = @colors[:views_bg]
              w.border_size = 0
            end
          end
        end
      end # }}}

      ## arrange {{{
      # Move expose windows to current screen
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
        @clients.each_with_index do |c, i|
          w   = @wins[i]
          len = w.write(6, @font_y + 3, "%s:%s" % [
            LETTERS[i], c.instance ]
          ) + 6

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

      ## expand {{{
      # Expand selector
      ##

      def expand
        if(@buffer.empty? and @expanded)
          @height   -= @font_height
          @expanded  = false

          @win.geometry = [ @x , @y, @width, @height ]
        elsif(!@expanded)
          @height   += @font_height
          @expanded  = true

          @win.geometry = [ @x , @y, @width, @height ]
        end
      end # }}}

      ## recolor {{{
      # Update colors of subwindos
      ##

      def recolor
        @wins.each_with_index do |w, i|
          # Highlight current and visible clients
          if(@clients[i] == @current)
            w.foreground = @colors[:focus_fg]
            w.background = @colors[:focus_bg]
          elsif(@visible.include?(@clients[i]))
            w.foreground = @colors[:occupied_fg]
            w.background = @colors[:occupied_bg]
          else
            w.foreground = @colors[:views_fg]
            w.background = @colors[:views_bg]
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
          w.show if(i < @clients.size)
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
  #Subtle::Contrib::Selector.font =
  # "xft:DejaVu Sans Mono:pixelsize=80:antialias=true"

  Subtle::Contrib::Selector.run
end

# vim:ts=2:bs=2:sw=2:et:fdm=marker
