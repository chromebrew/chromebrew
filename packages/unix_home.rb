require 'package'

class Unix_home < Package
  description 'Regular Unix home directory for Chrome OS'
  version '1.0'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'
  
  def self.install
    @HOME = "#{CREW_DEST_PREFIX}/home/#{USER}/"
    FileUtils.mkdir_p [@HOME, "#{CREW_DEST_PREFIX}/etc/env.d/"]
    
    FileUtils.ln_s Dir["#{Dir.home}/.bash*"], @HOME
    FileUtils.ln_s "#{Dir.home}/Downloads", @HOME
    FileUtils.ln_s "#{Dir.home}/MyFiles", @HOME + 'Documents'
    FileUtils.ln_s Dir.home, @HOME + 'chromeos'
    
    @env = <<~EOF
      set -a
      HOME=#{@HOME}
      ORIG_HOME=#{Dir.home}
      set +a
    EOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/unix_home", @env)
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