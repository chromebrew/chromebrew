require 'package'

class Torbrowser < Package
  description "'The Onion Router' browser"
  homepage 'https://www.torproject.org/'
  @_ver = '11.0.11'
  version @_ver
  license 'BSD, custom, MPL-2.0 and MIT'
  compatibility 'x86_64'
  source_url "https://dist.torproject.org/torbrowser/#{@_ver}/tor-browser-linux64-#{@_ver}_en-US.tar.xz"
  source_sha256 '6df94735440f608cb80c5b45c777a25a9aeaa5b5f0137dab28fce86d9b14a9b7'

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
    FileUtils.install 'tor', "#{CREW_DEST_PREFIX}/bin/tor", mode: 0o755
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
