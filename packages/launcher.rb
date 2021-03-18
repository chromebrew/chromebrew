require 'package'

class Launcher < Package
  description 'Add GUI applications shortcut to Chrome/Chromium OS launcher'
  homepage 'https://github.com/skycocker/chromebrew/tree/master/launcher'
  version '5.1'
  compatibility 'all'
  source_url 'https://github.com/supechicken/chromebrew/raw/master/launcher/launcher.rb'
  source_sha256 'be8c29ab3f96780b5287e52dabd5bf1fd28febdcffd959b688f2d4bf06d55791'
  
  depends_on 'em_websocket'
  depends_on 'imagemagick7'
    
  def self.install
    FileUtils.mkdir_p(CREW_DEST_PREFIX + '/bin')
    FileUtils.install('../launcher.rb', CREW_DEST_PREFIX + '/bin/launcher', mode: 0755)
  end
    
  def self.postinstall
    puts 'Performing code-injection...'
    @code = 'launcher start'
    system "echo '#{@code}' >> #{HOME}/.bashrc" unless `grep -c '#{@code}' #{HOME}/.bashrc`.to_i > 0
    puts
    puts "To get started, execute 'launcher help'.".lightblue
    puts
  end
end
