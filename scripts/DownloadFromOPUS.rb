#!/usr/bin/env ruby
#
#       DownloadFromOPUS.rb
#       
#       Copyright 2011 Francisco Hernandez <FJHernandez89@gmail.com>
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
#       
#       
require 'net/imap'
abort "#{$0} server user pass port" if (ARGV.size != 4)

class Net::IMAP  ## Net/IMAP class had to be extended, Just in Case(The authors RUBY did not have these methods)
def idle(&response_handler)
      raise LocalJumpError, "no block given" unless response_handler

      response = nil

      synchronize do
        tag = Thread.current[:net_imap_tag] = generate_tag
        put_string("#{tag} IDLE#{CRLF}")

        begin
          add_response_handler(response_handler)
          @idle_done_cond = new_cond
          @idle_done_cond.wait
          @idle_done_cond = nil
        ensure
          remove_response_handler(response_handler)
          put_string("DONE#{CRLF}")
          response = get_tagged_response(tag)
        end
      end

      return response
    end

    def idle_done
      synchronize do
        if @idle_done_cond.nil?
          raise Net::IMAP::Error, "not during IDLE"
        end
        @idle_done_cond.signal
      end
    end

end

class FetchOpus
	
	def set_server(*args)
		@server = *args.to_s
	end

	def set_user(*args)
		@user = *args.to_s
	end
	
	def set_pass(*args)
		@pass = *args.to_s
	end

	def set_port(*args)
		@port = *args
	end

	def mail_main
		@opus_inbox = Net::IMAP.new(@server, @port, true)
		@opus_inbox.login(@user,@pass)
		@opus_inbox.select('INBOX')
		
		@opus_inbox.idle { |resp|
			if resp.kind_of?(Net::IMAP::UntaggedResponse) and resp.name == "EXISTS"
    				@test = resp.data
				@opus_inbox.idle_done
			end
		}
		body = @opus_inbox.fetch(@test, 'BODY[TEXT]')
		puts body
	end
end

x = FetchOpus.new
x.set_server(ARGV[0])
x.set_user(ARGV[1])
x.set_pass(ARGV[2])
x.set_port(ARGV[3])
x.mail_main


