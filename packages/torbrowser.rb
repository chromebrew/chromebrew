require 'package'

class Torbrowser < Package
  description "'The Onion Router' browser"
  homepage 'https://www.torproject.org/'
  compatibility 'x86_64'
  @_ver = '10.0.12'
  version @_ver

  case ARCH
  when 'x86_64'
    source_url "https://www.torproject.org/dist/torbrowser/#{@_ver}/tor-browser-linux64-#{@_ver}_en-US.tar.xz"
    source_sha256 `curl -Ls #{@source_url} | sha256sum | cut -d ' ' -f1`.chomp
    depends_on 'gtk3'
    depends_on 'sommelier'
  end

  def self.build
    system "cat <<'EOF'> tor
#!/bin/bash
cd #{CREW_PREFIX}/share
./start-tor-browser.desktop \"\$@\"
EOF"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share"
    FileUtils.mv 'Browser/', "#{CREW_DEST_PREFIX}/share"
    FileUtils.mv 'start-tor-browser.desktop', "#{CREW_DEST_PREFIX}/share"
    FileUtils.install 'tor', "#{CREW_DEST_PREFIX}/bin/tor", mode: 0755
  end

  def self.postinstall
    puts
    puts "Type 'tor' to get started.".lightblue
    puts
  end
end
