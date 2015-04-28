#!/usr/bin/env ruby

require 'arii'
require 'JSON'
require 'logger'

if ARGV[0].nil? then
	p "[ARiiP] Please provide a configuration file."
else
	begin
		# create local log
		#logger = Logger.new File.new("#{Dir.pwd}/#{ARGV[0]}.log", "w+")	# log to file
		logger = Logger.new $stdout											# log to STDOUT
		# create new ARiiP client
		c = ARII::Client.new JSON.parse(IO.read(ARGV[0]), {:symbolize_names => true}), logger

		# start processing
		c.process
	rescue Exception => e
		p "[ARiiP] unable to process ARiiP: #{e}"
	end
end

