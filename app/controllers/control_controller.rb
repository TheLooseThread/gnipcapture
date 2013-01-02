class ControlController < ApplicationController
	require "fileutils"

	def index
		status = ""

		if params.has_key?(:capturestatus)
			status = ""
			all_ok = true
			path = "/home/deploy/gnip/streaming"
			latest_pt  = Dir.entries(path).glob("*.json").map{|f| File.mtime(path + "/" + f)}.max
			latest_edc = Dir.entries(path).glob("*.xml").map{|f| File.mtime(path + "/" + f)}.max
			status << "Most recent PT  capture time is #{Time.now-latest_pt} seconds old\n"
			status << "Most recent EDC capture time is #{Time.now-latest_edc} seconds old\n\n"
			if latest_pt and Time.now - latest_pt < 5*60
				status << "PT Capture OK\n"
			else
				status << "PT Capture FAIL\n"
				all_ok = false
			end
			if latest_edc and Time.now - latest_edc < 8*60*60
				status << "EDC Capture OK\n"
			else
				status << "EDC Capture FAIL\n"
				all_ok = false
			end
			status << "\nALL OK"
		end

		respond_to do |format|
			format.html { render text: "<pre>" + status + "</pre>"}			
    	end
	end

end
