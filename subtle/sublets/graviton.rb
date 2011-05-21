#!/usr/bin/ruby
#
# @file Graviton
#
# @copyright (c) 2010-2011, Christoph Kappel <unexist@dorfelite.net>
# @version $Id: ruby/graviton.rb,v 90 2011/03/23 16:08:21 unexist $
#
# This program can be distributed under the terms of the GNU GPLv2.
# See the file COPYING for details.
#
# Graviton is a helper to create custom gravities
#
# http://subforge.org/wiki/subtle-contrib/Wiki#Graviton
#

begin
  require "subtle/subtlext"
rescue LoadError
  puts ">>> ERROR: Couldn't find subtlext"
  exit
end

begin
  require "gtk2"
rescue LoadError
    puts <<EOF
>>> ERROR: Couldn't find the gem `gtk2'
>>>        Please install it with following command:
>>>        gem install gtk2
EOF
  exit
end

# Styler class
module Subtle # {{{
  module Contrib # {{{
    # Colors
    COLORS = {
      :cyan    => "#00FFFF",
      :green   => "#008000",
      :olive   => "#808000",
      :teal    => "#008080",
      :blue    => "#0000FF",
      :silver  => "#C0C0C0",
      :lime    => "#00FF00",
      :navy    => "#000080",
      :purple  => "#800080",
      :magenta => "#FF00FF",
      :maroon  => "#800000",
      :red     => "#FF0000",
      :yellow  => "#FFFF00",
      :gray    => "#808080"
    }

    # Rectangle class
    class Rectangle # {{{
      attr_accessor :x, :y, :width, :height, :color

      def initialize(x, y, width, height, color) # {{{
        @x      = x
        @y      = y
        @width  = width
        @height = height
        @color  = color
      end # }}}

      def is_edge?(x, y) # {{{
        if(x == @x and y == @y)
          :top_left
        elsif(x == (@x + @width) and y == @y)
          :top_right
        elsif(x == @x and y == (@y + @height))
          :bottom_left
        elsif(x == (@x + @width) and y == (@y + @height))
          :bottom_right
        else
          nil
        end
      end # }}}

      def to_gravity(width, height) # {{{
        w = @width * 100 / width
        h = @height * 100 / height
        x = @x * 100 / (width - w) % 100
        y = @y * 100 / (height - h) % 100

        "gravity :%s, [ %d, %d, %d, %d ]" % [ @color, x, y, w, h ]
      end # }}}

      def to_s # {{{
        "x=%d, y=%d, width=%d, height=%d" % [ @x, @y, @width, @height ]
      end # }}}
    end # }}}

    # Graviton class
    class Graviton < Gtk::Window # {{{


      ## initialize {{{
      # Init window
      ##

      def initialize
        super

        # Init sizes
        @geom          = Subtlext::Screen.current.geometry
        @gridsize      = 20
        @panel_x       = 7
        @panel_y       = 7
        @panel_width   = @geom.width / 2
        @panel_height  = @geom.height / 2

        @offset_width  = @panel_width % @gridsize
        @offset_height = @panel_height % @gridsize

        @panel_width  -= @offset_width
        @panel_height -= @offset_height

        @window_width  = @panel_width + 14
        @window_height = @panel_height + 44

        # Variables
        @rectangles    = []
        @cur_rect      = nil
        @cur_edge      = nil
        @sx            = 0
        @sy            = 0
        @x             = 0
        @y             = 0

        # Options
        set_title("Graviton for subtle #{Subtlext::VERSION}")
        set_wmclass("graviton", "subtle")
        set_resizable(false)
        set_keep_above(true)
        set_size_request(@window_width, @window_height)
        set_window_position(Gtk::Window::POS_CENTER)
        stick

        # Signals
        signal_connect("delete_event") do
          false
        end

        signal_connect("destroy") do
          Gtk.main_quit
        end

        # Alignment
        align = Gtk::Alignment.new(0.5, 0.5, 0.5, 0.5)
        align.set_padding(7, 7, 7, 7)

        add(align)

        # Vbox
        vbox = Gtk::VBox.new
        align.add(vbox)

        # Frame
        frame = Gtk::Frame.new
        frame.set_border_width(0)
        frame.set_shadow_type(Gtk::SHADOW_NONE)
        vbox.pack_start(frame)

        # Area
        @area = Gtk::DrawingArea.new
        @area.set_size_request(@panel_width, @panel_height)
        @area.add_events(
          Gdk::Event::POINTER_MOTION_MASK|
          Gdk::Event::BUTTON1_MOTION_MASK|
          Gdk::Event::BUTTON_PRESS_MASK|
          Gdk::Event::BUTTON_RELEASE_MASK
        )
        frame.add(@area)

        # Create context and surface
        @surface = Cairo::ImageSurface.new(Cairo::FORMAT_ARGB32,
          @panel_width, @panel_width
        )
        @ctxt = Cairo::Context.new(@surface)

        # Area events
        @area.signal_connect("expose_event") do |*args|
          expose_event(*args)
        end

        @area.signal_connect("motion_notify_event") do |*args|
          motion_event(*args)
        end

        @area.signal_connect("button_press_event") do |*args|
          press_event(*args)
        end

        @area.signal_connect("button_release_event") do |*args|
          release_event(*args)
        end

        # Hbox
        hbox = Gtk::HButtonBox.new
        vbox.pack_start(hbox, false, false, 2)

        # Print button
        button = Gtk::Button.new("Print")
        hbox.pack_start(button)

        button.signal_connect("clicked") do |*args|
          button_print(*args)
        end

        # Reset button
        button = Gtk::Button.new("Reset")
        hbox.pack_start(button)

        button.signal_connect("clicked") do
          @rectangles = []
          @area.signal_emit("expose_event", nil)
        end

        # Exit button
        button = Gtk::Button.new("Exit")
        hbox.pack_start(button)

        button.signal_connect("clicked") do
          Gtk.main_quit
        end

        show_all
      end # }}}

      private

      def GCD(num1, num2) # {{{
        if(0 == num1 % num2)
          return num2
        else
          return GCD(num2, num1 % num2)
        end
      end # }}}

      def expose_event(widget, event) # {{{
        # Clear
        @ctxt.set_source_rgba(0.0, 0.0, 0.0, 1.0)
        @ctxt.set_operator(Cairo::OPERATOR_SOURCE)
        @ctxt.paint

        # Grid
        @ctxt.set_line_width(1)
        @ctxt.set_source_rgba(0.6, 0.6, 0.6, 0.4)

        (0..@panel_width - 1).step(@gridsize) do |x|
          @ctxt.move_to(x, 0)
          @ctxt.line_to(x, @panel_width)
          @ctxt.move_to(0, x)
          @ctxt.line_to(@panel_width, x)
        end
        @ctxt.stroke

        # Center
        @ctxt.set_source_rgba(0.6, 0.0, 0.0, 0.4)
        @ctxt.move_to((@panel_width / 2) / @gridsize, 0)
        @ctxt.line_to((@panel_width / 2) / @gridsize, @panel_height)
        @ctxt.move_to(0, @panel_width / @gridsize)
        @ctxt.line_to(@panel_width, @panel_width / @gridsize)
        @ctxt.stroke

        # Rectangles
        @ctxt.set_line_width(1.0)
        @rectangles.each do |r|
          #@ctxt.set_dash((@cur_rect == r ? 2 : 0))
          @ctxt.set_source_color(Gdk::Color.parse(COLORS[r.color]))
          @ctxt.rectangle(r.x, r.y, r.width, r.height)

          # Cross
          @ctxt.move_to(r.x, r.y)
          @ctxt.line_to(r.x + r.width, r.y + r.height)
          @ctxt.move_to(r.x + r.width, r.y)
          @ctxt.line_to(r.x, r.y + r.height)
          @ctxt.stroke
        end

        # Position
        @ctxt.move_to(@x, @y)
        @ctxt.set_source_color(Gdk::Color.parse("#ff0000"))
        @ctxt.rectangle(@x - 2, @y - 2, 4, 4)
        @ctxt.stroke

        # Swap context
        ctxt = widget.window.create_cairo_context
        ctxt.set_source(@surface)
        ctxt.paint
      end # }}}

      def motion_event(widget, event) # {{{
        # Snap to closest grid knot
        modx = event.x % @gridsize
        mody = event.y % @gridsize

        @x = @gridsize / 2 < modx ? event.x - modx + @gridsize : event.x - modx
        @y = @gridsize / 2 < mody ? event.y - mody + @gridsize : event.y - mody

        # Calculate new width/height
        unless(@cur_rect.nil?)
          case @cur_edge
            when :top_left
              @cur_rect.x      = @x
              @cur_rect.y      = @y
              @cur_rect.width  = @sx - @x
              @cur_rect.height = @sy - @y
            when :top_right
              @cur_rect.x      = @sx
              @cur_rect.y      = @y
              @cur_rect.width  = @x - @sx
              @cur_rect.height = @sy - @y
            when :bottom_left
              @cur_rect.x      = @x
              @cur_rect.y      = @sy
              @cur_rect.width  = @sx - @x
              @cur_rect.height = @y - @sy
            when :bottom_right
              @cur_rect.x      = @sx
              @cur_rect.y      = @sy
              @cur_rect.width  = @x - @sx
              @cur_rect.height = @y - @sy
          end
        end

        expose_event(widget, event)
      end # }}}

      def press_event(widget, event) # {{{
        if(1 == event.button)
          # Find rectangles by edge
          @rectangles.each do |r|
            case(r.is_edge?(@x, @y))
              when :top_left
                @cur_rect = r
                @cur_edge = :top_left
                @sx       = r.x + r.width
                @sy       = r.y + r.height

                return
              when :top_right
                @cur_rect = r
                @cur_edge = :top_right
                @sx       = r.x
                @sy       = r.y + r.height

                return
              when :bottom_left
                @cur_rect = r
                @cur_edge = :bottom_left
                @sx       = r.x + r.width
                @sy       = r.y

                return
              when :bottom_right
                @cur_rect = r
                @cur_edge = :bottom_right
                @sx       = r.x
                @sy       = r.y

                return
              else
            end
          end

          if(@rectangles.size < COLORS.size)
            # Create new rectangle
            @mode     = :resize
            @cur_edge = :bottom_right
            @cur_rect = Rectangle.new(
              @x, @y, 20, 20,
              COLORS.keys[@rectangles.size]
            )
            @rectangles << @cur_rect

            @sx  = @x
            @sy  = @y
            @x  += @gridsize
            @y  += @gridsize

            expose_event(widget, event)
          else
            puts ">>> ERROR: Out of colors"
          end
        end
      end # }}}

      def release_event(widget, event) # {{{
        if(1 == event.button)
          @cur_rect = nil
          @cur_edge = nil
          @sx       = 0
          @sy       = 0
        end
      end # }}}

      def button_print(widget) # {{{
        @rectangles.each do |r|
          puts r.to_gravity(@geom.width, @geom.height)
        end
      end # }}}
    end # }}}
  end # }}}
end # }}}

# Implicitly run<
if(__FILE__ == $0)
  Gtk.init
  Subtle::Contrib::Graviton.new
  Gtk.main
end

# vim:ts=2:bs=2:sw=2:et:fdm=marker
