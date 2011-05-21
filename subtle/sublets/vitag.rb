#!/usr/bin/ruby
#
# @file Vitag
#
# @copyright (c) 2010-2011, Christoph Kappel <unexist@dorfelite.net>
# @version $Id: ruby/vitag.rb,v 92 2011/04/25 11:33:16 unexist $
#
# This program can be distributed under the terms of the GNU GPLv2.
# See the file COPYING for details.
#
# Vitag is a helper to edit window/view tagging with any $EDITOR
#
# http://subforge.org/projects/subtle-contrib/wiki/Vitag
#

require "tempfile"

begin
  require "subtle/subtlext"
rescue LoadError
  puts ">>> ERROR: Couldn't find subtlext"
  exit
end

# Check if $EDITOR is set
if(ENV["EDITOR"].nil?)
  puts <<EOF
>>> ERROR: Couldn't find $EDITOR envorinment variable
>>>        Please set it like this: export EDITOR=vim
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
if(2316 > teeny)
  puts ">>> ERROR: vitag needs at least subtle `0.9.2316' (found: %s)" % [
    Subtlext::VERSION
  ]
  exit
end

# Collect views and clients
views   = Subtlext::View.all
clients = Subtlext::Client.all

# Create temp file
temp = Tempfile.new("vitag-")

# Fill in tags
temp.puts("# Views")
views.each do |v|
  temp.puts("@%s %s" % [
    v.name,
    v.tags.map { |t| "#%s" % [ t ] }.join(" ")
  ])
end

# Fill in tags
temp.puts("")
temp.puts("# Clients")
clients.each do |c|
  temp.puts("%s %s" % [
    c.instance,
    c.tags.map { |t| "#%s" % [ t ] }.join(" ")
  ])
end

temp.flush

# Start editor
system("$EDITOR %s" % [ temp.path ])

temp.rewind

# Read temp file
temp.readlines.each do |l|
  next if(l.start_with?("#") or l.empty?)

  value, *tags = l.delete("@#").split(" ")

  # Select type
  case(value)
    when /^@/ then cur = views.select { |v| v.name == value }.first
    else           cur = clients.select { |c| c.instance == value }.first
  end

  # Check for valid objects and changed tags
  if(cur and cur.tags.map(&:name) != tags)
    tags.map! do |name|
      # Find or create tags
      tag = Subtlext::Tag[name] || Subtlext::Tag.new(name)
      tag.save

      tag
    end

    p "#{cur.id}: cur=#{cur}, tags=#{tags}"

    # Finally assign tags
    cur.tags = tags

    cur = nil
  end
end

temp.close

# vim:ts=2:bs=2:sw=2:et:fdm=marker
