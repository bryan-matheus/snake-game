#module from this answer http://stackoverflow.com/questions/946738/detect-key-press-non-blocking-w-o-getc-gets-in-ruby
#we are getting keypress without waiting for it
module GetKey
    # Check if Win32API is accessible or not
    @use_stty = begin
        require 'Win32API'
            false
        rescue LoadError
            # Use Unix way
            true
    end
  
    # Return the ASCII code last key pressed, or nil if none
    #
    # Return::
    # * _Integer_: ASCII code of the last key pressed, or nil if none
    def self.getkey
        if @use_stty
            system('stty raw -echo') # => Raw mode, no echo
            char = (STDIN.read_nonblock(1).ord rescue nil)
            system('stty -raw echo') # => Reset terminal mode
            return char
        else
            return Win32API.new('crtdll', '_kbhit', [ ], 'I').Call.zero? ? nil : Win32API.new('crtdll', '_getch', [ ], 'L').Call
        end
    end
end