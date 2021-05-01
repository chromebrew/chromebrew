require 'package'

class Torbrowser < Package
  description "'The Onion Router' browser"
  homepage 'https://www.torproject.org/'
  @_ver = '10.0.15'
  version @_ver
  license 'BSD, custom, MPL-2.0 and MIT'
  compatibility 'x86_64'

  @_url = "https://www.torproject.org/dist/torbrowser/#{@_ver}"
  @_name = "tor-browser-linux64-#{@_ver}_en-US.tar.xz"
  source_url "#{@_url}/#{@_name}"
  source_sha256 '3a73b44f68fe97c4d89984fd0a23be069c495ada7ecf97dc3060c6e7aa4c06aa'

  depends_on 'gtk3'
  depends_on 'sommelier'

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
    print "\nSet Tor as your default browser? [Y/n]: "
    case STDIN.getc
    when "\n", 'Y', 'y'
      Dir.chdir("#{CREW_PREFIX}/bin") do
        FileUtils.ln_sf 'tor', 'x-www-browser'
      end
      puts 'Tor is now your default browser.'.lightgreen
    else
      puts 'No change has been made.'.orange
    end
    puts "\nType 'tor' to get started.\n".lightblue
  end

  def self.remove
    Dir.chdir("#{CREW_PREFIX}/bin") do
      if File.exist?('x-www-browser') and File.symlink?('x-www-browser') \
        and File.realpath('x-www-browser') == "#{CREW_PREFIX}/bin/tor"
        FileUtils.rm 'x-www-browser'
      end
    end
  end
end
