require 'package'

class Torbrowser < Package
  description "'The Onion Router' browser"
  homepage 'https://www.torproject.org/'
  @_ver = '11.5.1'
  version @_ver
  license 'BSD, custom, MPL-2.0 and MIT'
  compatibility 'x86_64'
  source_url "https://dist.torproject.org/torbrowser/#{@_ver}/tor-browser-linux64-#{@_ver}_en-US.tar.xz"
  source_sha256 '2e0cefa6d4284c71a7816e310d935f9b9b5e4a3a408dc53330a0db0474489e8a'

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
