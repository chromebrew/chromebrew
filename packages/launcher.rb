require 'package'

class Launcher < Package
  description 'Add GUI applications shortcut to Chrome/Chromium OS launcher'
  homepage 'https://github.com/supechicken/chromebrew/tree/master/launcher'
  version '5.0'
  source_url 'https://github.com/supechicken/chromebrew/raw/master/launcher/launcher.rb'
  source_sha256 '117615ee5f2cf5096c8fef274cfa3cc94c2161b5b23e080ff199081c18b5c0a7'
  
  depends_on 'libyaml'
  depends_on 'imagemagick7'

  def self.install
    system('gem', 'install', 'em-websocket')
    FileUtils.mkdir_p(CREW_DEST_PREFIX + '/bin')
    FileUtils.install('../launcher.rb', CREW_DEST_PREFIX + '/bin/launcher', mode: 0755)
  end
    
  def self.postinstall
    puts 'Performing code-injection...'
    @code = 'launcher start'
    system "echo 'nohup #{@code}' >> #{HOME}/.bashrc" unless `grep -c '#{@code}' #{HOME}/.bashrc`.to_i > 0
    puts
    puts "To get started, execute 'launcher help'.".lightblue
    puts
  end
end
