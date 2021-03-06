require 'package'

class Torbrowser < Package
  description "'The Onion Router' browser"
  homepage 'https://www.torproject.org/'
  compatibility 'x86_64'
  @_ver = '10.0.13'
  version @_ver

  case ARCH
  when 'x86_64'
    @_url = "https://www.torproject.org/dist/torbrowser/#{@_ver}"
    @_name = "tor-browser-linux64-#{@_ver}_en-US.tar.xz"
    source_url "#{@_url}/#{@_name}"
    source_sha256 `curl -Ls '#{@_url}/sha256sums-signed-build.txt' | grep '#{@_name}' | cut -d' ' -f1`.chomp
    depends_on 'gtk3'
    depends_on 'sommelier'
  end

  def self.build
    @tor = <<~EOF
      #!/bin/sh -e
      cd #{CREW_PREFIX}/share/
      ./start-tor-browser.desktop "$@"
    EOF
    File.write('tor', @tor)
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share"
    FileUtils.mv 'Browser/', "#{CREW_DEST_PREFIX}/share/"
    FileUtils.mv 'start-tor-browser.desktop', "#{CREW_DEST_PREFIX}/share"
    FileUtils.install 'tor', "#{CREW_DEST_PREFIX}/bin/tor", mode: 0755
  end

  def self.postinstall
    puts
    puts 'Set Tor as your default browser? [Y/n]: '
    case STDIN.gets.chomp
    when "\n", 'Y', 'y', 'yes'
      Dir.chdir("#{CREW_PREFIX}/bin") do
        FileUtils.ln_sf 'tor', 'x-www-browser'
      end
    else
      puts 'No change has been made.'
      puts
    end
    
    puts
    puts "Type 'tor' to get started.".lightblue
    puts
  end
  
  def self.remove
    Dir.chdir("#{CREW_PREFIX}/bin") do
      FileUtils.rm 'x-www-browser' if File.realpath('x-www-browser') == "#{CREW_PREFIX}/bin/tor"
    end    
  end
end
