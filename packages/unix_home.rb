require 'package'

class Unix_home < Package
  description 'Regular Unix home directory for Chrome OS'
  version '1.0'
  compatibility 'all'
  license 'GPL-3+'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'
  
  def self.install
    @HOME = "#{CREW_DEST_PREFIX}/home/#{USER}/"
    FileUtils.mkdir_p [@HOME, "#{CREW_DEST_PREFIX}/etc/env.d/"]
    
    FileUtils.ln_s Dir["#{HOME}/.bash*"], @HOME
    FileUtils.ln_s "#{HOME}/Downloads", @HOME
    FileUtils.ln_s "#{HOME}/MyFiles", @HOME + 'Documents'
    FileUtils.ln_s HOME, @HOME + 'chromeos'
    
    @env = <<~EOF
      set -a
      HOME=#{@HOME}
      ORIG_HOME=#{HOME}
      set +a
    EOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/unix_home", @env)
    # add original home directory to const.rb
    system "echo 'ORIG_HOME=#{HOME}' >> #{CREW_LIB_PATH}/lib/const.rb"
    
    # cover HOME variable for dependencies after this package
    # undefine HOME variable
    Object.send(:remove_const, :HOME)
    # define it
    HOME = @HOME
  end
  
  def self.postinstall
    puts <<~EOT.lightblue
      
      The home directory has been changed to #{CREW_PREFIX}/home/#{USER} with shared 'Downloads' directory
      Type '~/chromeos/' to access the original home directory
      
      The original '~/MyFiles' directory is linked to '~/Documents'
      
      To complete the installation, execute the following:
      
      source ~/.bashrc
    EOT
  end
end
