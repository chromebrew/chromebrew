require 'package'

class Integration < Package
  description 'Improves integration with Chrome OS shell and Chromebrew GUI applications.'
  homepage 'https://github.com/skycocker/chromebrew/crew_integration'
  version '3.0'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'
  
  depends_on "graphicsmagick"
    
  case ARGV[0]
  when 'reinstall'
     puts "Since you are reinstalling this package, please run 'pkill ruby' if installation failed".lightblue
  when 'upgrade'
     puts "Since you are upgrading this package, please run 'pkill ruby' if installation failed".lightblue
  end

  def self.install
    # system "curl https://codeload.github.com/skycocker/chromebrew/zip/master -#o crew_integration.zip"
    system "curl https://codeload.github.com/supechicken/chromebrew/zip/supechicken-patch-1 -#o crew_integration.zip"
    puts 'Archive downloaded'.lightgreen
    system "unzip crew_integration.zip > /dev/null"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.ln_s '/bin/mkdir', "#{CREW_PREFIX}/bin/mkdir" unless File.exist? "#{CREW_PREFIX}/bin/mkdir"
    FileUtils.ln_s '/usr/bin/install', "#{CREW_PREFIX}/bin/install" unless File.exist? "#{CREW_PREFIX}/bin/install"
    system "gem install em-websocket"
    FileUtils.safe_unlink "#{CREW_PREFIX}/bin/mkdir"
    FileUtils.safe_unlink "#{CREW_PREFIX}/bin/install"
    FileUtils.chmod_R '+rw', './'
    #Dir.chdir "chromebrew-master/integration" do
    Dir.chdir "chromebrew-supechicken-patch-1/integration" do
      FileUtils.install 'main.sh', "#{CREW_DEST_PREFIX}/bin/crew_integration", mode: 755
      FileUtils.install 'x-terminal-emulator.sh', "#{CREW_DEST_PREFIX}/bin/x-terminal-emulator", mode: 755
      FileUtils.install 'x-www-browser.sh', "#{CREW_DEST_PREFIX}/bin/x-www-browser", mode: 755
      FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/lib/pwa/"
      FileUtils.ln_s "#{CREW_PREFIX}/bin/crew_integration", "#{CREW_DEST_PREFIX}/bin/pwashortcut"
      FileUtils.mkdir_p "#{CREW_DEST_HOME}/MyFiles/.extension/"
      FileUtils.mv Dir.glob('extension/*'), "#{CREW_DEST_HOME}/MyFiles/.extension/"
      FileUtils.mv Dir.glob('*'), "#{CREW_DEST_PREFIX}/lib/pwa/"
      FileUtils.ln_s "#{CREW_PREFIX}/lib/pwa/send.rb", "#{CREW_DEST_PREFIX}/lib/pwa/sender.rb"
    end 
  end
  def self.postinstall
      unless ARGV[0] == "upgrade"
        require 'em-websocket'
        puts 
        puts "To complete the installation, install the extension by following:".lightgreen
        puts "Go to chrome://extensions/".lightgreen
        puts "Switch on Developer Mode".lightgreen
        puts "Click 'Load Unpacked'".lightgreen
        puts "Click the 'More' button (icon with three dots) in top-right side of the new window".lightgreen
        puts "Select 'Display hidden files'".lightgreen
        puts "Select the '.extension' folder under 'MyFiles'".lightgreen
        puts
        EM.run {
         EM::WebSocket.run(:host => "0.0.0.0", :port => 25500) do |ws|
           ws.onopen { |handshake| }
           ws.onmessage { |message|
             `sed -i "s/id_id/#{message}/g" #{CREW_PREFIX}/bin/crew_integration`
             EM::WebSocket.stop
           }
         end
        }
      end
      puts "This package contain a terminal shortcut, execute the following to install".lightblue
      puts "crew_integration -i".lightblue
      puts
      puts "Run 'crew_integration -h' for more usage of this package".lightblue
      puts
  end
  def self.remove
      FileUtils.rm_rf "#{CREW_LIB_PREFIX}/pwa/"
      FileUtils.rm_rf "#{HOME}/.extension/"
  end
end
