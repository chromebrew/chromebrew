require 'package'

class Torbrowser < Package
  description "'The Onion Router' browser"
  homepage 'https://www.torproject.org/'
  @_ver = '11.5.7'
  version @_ver
  license 'BSD, custom, MPL-2.0 and MIT'
  compatibility 'x86_64'
  source_url "https://dist.torproject.org/torbrowser/#{@_ver}/tor-browser-linux64-#{@_ver}_en-US.tar.xz"
  source_sha256 '2b9d13f457bab4cb8fd49e607f02bd7ffdb965e6a443dbec262e0838f6ba7cc9'

  depends_on 'gtk3'
  depends_on 'sommelier'

  def self.build
    tor = <<~EOF
      #!/bin/bash
      SCALE=1
      RESOLUTION=$(xdpyinfo | awk '/dimensions:/ { print $2 }' | cut -d'x' -f1)
      [[ $RESOLUTION -gt 1500 && $RESOLUTION -lt 2500 ]] && SCALE=1.5
      [[ $RESOLUTION -ge 2500 && $RESOLUTION -lt 3500 ]] && SCALE=2
      [[ $RESOLUTION -ge 3500 && $RESOLUTION -lt 4500 ]] && SCALE=2.5
      [[ $RESOLUTION -ge 4500 && $RESOLUTION -lt 5500 ]] && SCALE=3
      [[ $RESOLUTION -gt 5500 ]] && SCALE=3.5
      [ -z "$DISPLAY" ] && DISPLAY=':0'
      export GDK_BACKEND=x11
      export GDK_SCALE=$SCALE
      export DISPLAY=$DISPLAY
      cd #{CREW_PREFIX}/share/
      ./start-tor-browser.desktop "$@"
    EOF
    File.write('tor', tor)
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
    case $stdin.gets.chomp.downcase
    when '', 'y', 'yes'
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
      if File.exist?('x-www-browser') && File.symlink?('x-www-browser') \
        && (File.realpath('x-www-browser') == "#{CREW_PREFIX}/bin/tor")
        FileUtils.rm 'x-www-browser'
      end
    end
  end
end
