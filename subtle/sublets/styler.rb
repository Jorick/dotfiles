#!/usr/bin/ruby
#
# @file Styler
#
# @copyright (c) 2010-2011, Christoph Kappel <unexist@dorfelite.net>
# @version $Id: ruby/styler.rb,v 90 2011/03/23 16:08:21 unexist $
#
# This program can be distributed under the terms of the GNU GPLv2.
# See the file COPYING for details.
#
# Styler is a helper to create or change subtle color themes
#
# http://subforge.org/wiki/subtle-contrib/Wiki#Styler
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

# Check whether subtle is running
unless(Subtlext::Subtle.running?)
  puts ">>> ERROR: Couldn't find running subtle"
  exit
end

# Check for subtlext version
major, minor, teeny = Subtlext::VERSION.split(".").map(&:to_i)
if(2429 > teeny)
  puts ">>> ERROR: styler needs at least subtle `0.9.2429' (found: %s)" % [
    Subtlext::VERSION
  ]
  exit
end

# Styler class
module Subtle # {{{
  module Contrib # {{{
    class Styler < Gtk::Window # {{{
      WINDOW_WIDTH  = 650
      WINDOW_HEIGHT = 430
      PANEL_HEIGHT  = 16
      DEFAULT_COLOR = "#000000"

      ## initialize {{{
      # Init window
      ##

      def initialize
        super

        # Options
        set_title("Styler for subtle #{Subtlext::VERSION}")
        set_wmclass("styler", "subtle")
        set_resizable(false)
        set_keep_above(true)
        set_size_request(WINDOW_WIDTH, WINDOW_HEIGHT)
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
        vbox = Gtk::VBox.new()
        align.add(vbox)

        # Frame
        frame = Gtk::Frame.new
        frame.set_border_width(0)
        frame.set_shadow_type(Gtk::SHADOW_NONE)
        vbox.pack_start(frame)

        # Area
        @area = Gtk::DrawingArea.new
        @area.set_size_request(450, 80)
        @area.signal_connect("expose_event") do
          expose(@area.window.create_cairo_context)
        end
        frame.add(@area)

        # Table
        table = Gtk::Table.new(8, 9)
        vbox.pack_start(table, true, false, 5)

        # Get colors
        @colors = {}
        @all    = [ :all_fg, :all_bg, :all_border ]
        Subtlext::Subtle.colors.map { |k, v|  @colors[k] = v.to_hex }
        @all.map { |v| @colors[v] = DEFAULT_COLOR }

        # Color buttons
        row      = 0
        col      = 0
        @buttons = {}

        [ "fg", "bg", "border", "active", "el", "und", "le", "tor" ].each do |suffix|
          @colors.keys.select { |k, v|
            k.to_s[(suffix.length * -1)..-1] == suffix
          }.each do |name|
            @buttons[name] = color_button(table, row, col, name)

            row += 1
          end

          if(6 <= row)
            row  = 0
            col += 2
          end
        end

        # Hbox
        hbox = Gtk::HButtonBox.new
        vbox.pack_start(hbox, false, false, 5)

        # Print button
        button = Gtk::Button.new("Print")
        hbox.pack_start(button, false, false, 2)
        button.signal_connect("clicked") do
          last = nil

          @colors.to_a[0..-4].each do |a|
            s = a.first.to_s.split("_").first

            if(s != last)
              puts
              last = s
            end

            puts 'color :%-16s "%s"' % [ a.first.to_s + ",", a.last ]
          end
        end

        # Wiki button
        button = Gtk::Button.new("Wiki")
        hbox.pack_start(button, false, false, 2)
        button.signal_connect("clicked") do
          last = nil

          puts "{{theme(NEW_THEME, %s)}}" % [
            @colors.to_a[0..-4].map { |a|
              ':%s=>"%s"' % [ *a ]
            }.join(", ")
          ]
        end

        # Reset button
        button = Gtk::Button.new("Reset")
        hbox.pack_start(button, false, false, 2)
        button.signal_connect("clicked") do
          @colors = {}
          idx     = 0

          # Reset color buttons
          Subtlext::Subtle.colors.each do |k, v|
            hexcolor = v.to_hex

            @colors[k] = hexcolor
            @buttons[k].set_color(Gdk::Color.parse(hexcolor))
          end

          # Set all-color buttons
          @buttons[:all_fg].set_color(Gdk::Color.parse(DEFAULT_COLOR))
          @buttons[:all_bg].set_color(Gdk::Color.parse(DEFAULT_COLOR))
          @buttons[:all_border].set_color(Gdk::Color.parse(DEFAULT_COLOR))

          @area.signal_emit("expose-event", nil)
        end

        # Exit button
        button = Gtk::Button.new("Exit")
        hbox.pack_start(button, false, false, 2)
        button.signal_connect("clicked") do
          Gtk.main_quit
        end

        show_all
      end # }}}

      private

      def scale_round(val, factor) # {{{
        val = (val * factor + 0.5).floor
        val = val > 0      ? val    : 0   #< Min
        val = val > factor ? factor : val #< Max

        val
      end # }}}

      def color_button(table, row, col, name) # {{{
        caption  = name.to_s.split(/[^a-z0-9]/i).map { |w| w.capitalize }.join(" ")
        label    = Gtk::Label.new(caption)
        button   = Gtk::ColorButton.new(
          Gdk::Color.parse(@colors[name])
        )

        # Align
        align = Gtk::Alignment.new(1.0, 0.0, 0, 0)
        align.add(label)

        # Signal handler
        button.signal_connect("color-set") do |button|
          begin
            # Assemble hex color
            hexcolor = "#%02x%02x%02x" % [
              scale_round((button.color.red.to_f   / 65535), 255),
              scale_round((button.color.green.to_f / 65535), 255),
              scale_round((button.color.blue.to_f  / 65535), 255)
            ]

            # Update colors
            if(@all.include?(name))
              suffix = name.to_s.split("_").last

              @colors.keys.select { |k, v|
                k.to_s[(suffix.length * -1)..-1] == suffix
              }.each do |name|
                @colors[name] = hexcolor
                @buttons[name].set_color(button.color)
              end
            else
              @colors[name] = hexcolor
            end

            @area.signal_emit("expose-event", nil)
          rescue => error
            puts error, error.backtrace
          end
        end

      # Attach to table
      table.attach(align, 0 + col, 1 + col, 0 + row, 1 + row,
        Gtk::SHRINK, Gtk::SHRINK, 5, 5)
      table.attach(button, 1 + col, 2 + col, 0 + row, 1 + row,
        Gtk::SHRINK, Gtk::SHRINK, 5, 5)

        return button
      end # }}}

      def expose(cr) # {{{
        # Border
        cr.set_source_rgb(1.0, 0.0, 0.0)
        cr.rectangle(0, 0, WINDOW_WIDTH, 70)
        cr.fill

        # Panel
        cr.set_source_color(Gdk::Color.parse(@colors[:panel]))
        cr.rectangle(2, 2, WINDOW_WIDTH - 28, PANEL_HEIGHT)
        cr.fill

        # Clients
        draw_client(cr, "client (focus)", 2, true)
        draw_client(cr, "client", 313)

        # Panel items
        x = 2

        {
          "terms"    => 42,
          "www"      => 37,
          "urgent"   => 47,
          "occupied" => 60,
          "focus"    => 40
        }.each do |name, width|
          draw_item(cr, name, x, width, case name
              when "terms"    then :focus
              when "www"      then :views
              when "urgent"   then :urgent
              when "occupied" then :occupied
              when "focus"    then :title
            end
          )
          x += width
        end

        # Sublets
        draw_item(cr, "sublet", 530, 44, :sublets)
        draw_text(cr, "|", 575, 15, :separator)
        draw_item(cr, "sublet", 579, 44, :sublets)
      end # }}}

      def draw_item(cr, name, x, width, state) # {{{
        # Border
        if(@colors.has_key?(("%s_border" % [ state ]).to_sym))
          cr.set_source_color(
            Gdk::Color.parse(@colors[("%s_border" % [ state ]).to_sym])
          )
          cr.rectangle(x, 2, width, PANEL_HEIGHT)
          cr.fill

          border = 1
        else
          border = 0
        end

        # Frame
        cr.set_source_color(
          Gdk::Color.parse(@colors[("%s_bg" % [ state ]).to_sym])
        )

        cr.rectangle(x + border, 2 + border,
          width - 2 * border, PANEL_HEIGHT - 2 * border)
        cr.fill

        # Text
        draw_text(cr, name, x + 5, 15, ("%s_fg" % [ state ]).to_sym)
      end # }}}

      def draw_text(cr, text, x, y, color) # {{{
        cr.set_source_color(Gdk::Color.parse(@colors[color]))
        cr.select_font_face("Arial", "normal")
        cr.set_font_size(12)
        cr.move_to(x, y)
        cr.show_text(text)
        cr.stroke
      end # }}}

      def draw_client(cr, name, x, focus = false) # {{{
        # Border
        cr.set_source_color(Gdk::Color.parse(
          focus ? @colors[:client_active] : @colors[:client_inactive]
        ))
        cr.rectangle(x, 2 + PANEL_HEIGHT, 311, 50)
        cr.fill

        border = 2

        # Frame
        cr.set_source_color(Gdk::Color.parse(@colors[:background]))
        cr.rectangle(x + border, 2 + PANEL_HEIGHT + border,
          311 - 2 * border, 50 - 2 * border)
        cr.fill

        # Text
        draw_text(cr, name, x + 5, 33, :stipple)
      end # }}}
    end # }}}
  end # }}}
end # }}}

# Implicitly run<
if(__FILE__ == $0)
  Gtk.init
  Subtle::Contrib::Styler.new
  Gtk.main
end

# vim:ts=2:bs=2:sw=2:et:fdm=marker
