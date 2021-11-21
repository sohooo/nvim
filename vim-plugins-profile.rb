#!/usr/bin/env ruby
# encoding: utf-8

# Copyright 2015-2020, Hörmet Yiltiz <hyiltiz@github.com>
# Released under GNU GPL version 3 or later.
#
# => adapted for this config by sohooo

vim = "nvim"
file = ARGV.first || ""
puts "Testing #{vim} performance..."

PLOT_WIDTH = 120
LOG = "vim-plugins-profile.#{$$}.log".freeze

XDG_CONFIG_HOME = ENV["XDG_CONFIG_HOME"] || File.join(ENV["HOME"], ".config")

VIMFILES_DIR = vim == "nvim" ? File.join(XDG_CONFIG_HOME, "nvim") : File.join(ENV["HOME"], ".vim")
puts "Assuming your vimfiles folder is #{VIMFILES_DIR}."

puts "Generating #{vim} startup profile..."
system(vim, "--startuptime", LOG, file, "-c", "q")

# packer plugin manager
plug_dir = "#{ENV['HOME']}/.local/share/nvim/site/pack/packer/start"

# parse
exec_times_by_name = Hash.new(0)
lines = File.readlines(LOG).select { |line| line =~ /sourcing.*#{Regexp.escape(plug_dir)}/ }
lines.each do |line|
  trace_time, source_time, exec_time, _, path = line.split(" ")
  relative_path = path.gsub(plug_dir + "/", "")
  name = File.basename(relative_path.split("/")[0], ".vim")
  time = exec_time.to_f
  exec_times_by_name[name] += time
end

# plot
max = exec_times_by_name.values.max
relatives = exec_times_by_name.reduce({}) do |hash, (name, time)|
  hash.merge!(name => time / max.to_f)
end
max_name_length = relatives.keys.map(&:length).max
puts
Hash[relatives.sort_by { |_k, v| -v }].each do |name, rel_time|
  time = exec_times_by_name[name]
  puts "#{name.rjust(max_name_length)}: (#{time.round(3).to_s.ljust(5)}ms) #{'*' * (rel_time * PLOT_WIDTH)}"
end

File.delete(LOG)
