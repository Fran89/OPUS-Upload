#!/usr/bin/env ruby
#
#       UploadToOPUS.rb
#       
#       Copyright 2011 Francisco Hernandez <francisco@francisco-laptop>
#       
#       This program is free software; you can redistribute it and/or modify
#       it under the terms of the GNU General Public License as published by
#       the Free Software Foundation; either version 2 of the License, or
#       (at your option) any later version.
#       
#       This program is distributed in the hope that it will be useful,
#       but WITHOUT ANY WARRANTY; without even the implied warranty of
#       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#       GNU General Public License for more details.
#       
#       You should have received a copy of the GNU General Public License
#       along with this program; if not, write to the Free Software
#       Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#       MA 02110-1301, USA. 

require "rubygems"
gem "selenium-client"
require "selenium/client"

abort "#{$0} email filename height" if (ARGV.size != 3)


class OPUS 

  def setup
	
    @verification_errors = []
    @selenium = Selenium::Client::Driver.new \
      :host => "127.0.0.1",
      :port => 4444,
      :browser => "*firefox",
      :url => "http://www.ngs.noaa.gov/",
      :timeout_in_second => 60
      

    @selenium.start_new_browser_session
  end
  
  def setmail(*args)
  @mail = *args
  end
  
  def setfile(*args)
  @file = *args
  end
  
  def setheight(*args)
  @height = *args
  end
  
  def teardown
    @selenium.close_current_browser_session
    #assert_equal [], @verification_errors
  end
  
  def main_opus
    @selenium.open "/OPUS/"
    
    @selenium.type "name=email_address", @mail.shift.strip
    @selenium.type "name=height", @height.shift.strip
    @selenium.type "name=uploadfile",  @file.shift.strip
    
    #Trimble Choke Ring
    #@selenium.select "ant_type", "label=regexp:TRM49700\\.00\\s+NONE\\sTrimble\\sChoke\\sRing\\sP/N:49700-00\\s+"
    
    #Trimble Zephyr GNSS GPS/GLONASS
    # @selenium.select "ant_type", "label=regexp:TRM55970\\.00\\s+Zephyr\\sGNSS\\s\\(GPS/GLONASS\\)\\s+"
    
    #Trimble Zephyr TZGD
    @selenium.select "ant_type", "label=regexp:TRM55970\\.00\\s+Zephyr\\sGNSS\\s\\(GPS/GLONASS\\)\\s+"
    
    
    @selenium.click "Static"
    # selenium.click "Rapid-Static"
    @selenium.get_confirmation
    @selenium.wait_for_page_to_load(100000000)
    !1000.times{ 
		if(@selenium.is_text_present("Upload successful!"))
			break
		elsif(@selenium.is_text_present("Upload failed"))
			puts "error"
			break
		else
			sleep 1
		end 
    }
    
  end
  
end
firefox = OPUS.new
firefox.setmail(ARGV[0])
firefox.setfile(ARGV[1])
firefox.setheight(ARGV[2])
firefox.setup
firefox.main_opus
firefox.teardown
