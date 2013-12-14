# Runs a command
#
# ==== Params
#
# * +cmd+ - A string with a command
# * +opts+ - A hash of options
#
# ==== opts
#
# * +:stderr+ - Print stderr on console
# * +:stdout+ - Print stdout on console
# * +:exit_on_error+ - Exit main program on command error
# * +:timeout+ - Execution timeout in seconds
#
# ==== Examples
#
# myexec "ls -R /', opts = {:stderr => false, :stdout => true, :exit_on_error => true ,:timeout => 3}
#



def myexec cmd, opts = {:stderr => false, :stdout => true, :exit_on_error => true ,:timeout => 3}

  command = File.basename($0)
  exit_status = 0
  start = Time.new

  begin 
    stdin,stdout,stderr,wait_thr = Open3.popen3(cmd)
    pid = wait_thr.pid
    # This block uses kernel.select to monitor if there is data on stdout IO 
    # object every 1 second. Then we use a nonblocking read ... so the whole 
    # idea is: Check if there is stdin to read, in 1 second unblock and 
    # try to read. Loop every 1 second over and over the same process until 
    # the process finishes or timeout is reached.
    elapsed = 0
    while wait_thr.status and (elapsed = Time.now - start) < opts[:timeout]
      Kernel.select([stdout],nil,nil,1)
      # Read is blocker as well so read non block
      begin
        output = stdout.read_nonblock(100) 
        print output if opts[:stdout]
      rescue IO::WaitReadable
        # Exception raised when there is nothing to read
      rescue EOFError
        # Exception raised EOF is reached
        break
      end
    end
    if elapsed > opts[:timeout]
      # We need to kill the process 
      Process.kill("KILL", pid)
      raise "Timeout"
    end

    # Handle the exit status:
    exit_status = wait_thr.value.exitstatus
    if exit_status > 0
      $stderr.puts "#{command} error: Command returned non zero - error was:\n#{stderr.read}".red if opts[:stderr]
      exit if opts[:exit_on_error]
    end

  rescue => e
    $stderr.puts "\n#{command} error: Command failed, error was:\n#{e}".red
    exit 1 if opts[:exit_on_error]
    exit_status = 127
  end


end

def load_config_file

  command = File.basename($0)
  config = nil

  begin

    File.open("/opt/webtools/conf/settings.yaml") do |file|
      content = file.read
      config = YAML::load(content)
    end

  rescue => e

    $stderr.puts "#{command} error: Error while reading config file".red
    $stderr.puts "Error was: #{e}".red
    exit 1

  end

  config

end
