class ControlController < ApplicationController
	require "fileutils"

	def index
		status = ""

		if params.has_key?(:capturestatus)
			latest = Dir.entries("/home/deploy/gnip/streaming").map{|f| File.mtime(f)}.max
			status = "Most recent capture time is #{Time.now-latest} seconds old\n\n"
			if latest and Time.now - latest < 5*60
				status << "Capture OK\n"
			else
				status << "Capture FAIL\n"
			end
		end

		respond_to do |format|
			format.html { render text: "<pre>" + status + "</pre>"}			
    	end
	end

end
