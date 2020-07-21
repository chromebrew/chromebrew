require 'package'

class Firefox < Package
  description 'Mozilla Firefox (or simply Firefox) is a free and open-source web browser'
  homepage 'https://www.mozilla.org/en-US/firefox/'
  version '78.0.2'
  compatibility 'i686,x86_64'
  case ARCH
  when 'i686'
    source_url 'https://archive.mozilla.org/pub/firefox/releases/78.0.2/linux-i686/en-US/firefox-78.0.2.tar.bz2'
    source_sha256 '8e6d63f2ff1c3a2644cc0d392db079b2a1228a9ce587c046245feb7d0a0a53e7'
  when 'x86_64'
    source_url 'https://archive.mozilla.org/pub/firefox/releases/78.0.2/linux-x86_64/en-US/firefox-78.0.2.tar.bz2'
    source_sha256 'b50d010f2db643bebd3f54d13a079833e25f03e4b163ffe98771596fafe8c487'
  end

  case ARCH
  when 'i686', 'x86_64'
    depends_on 'gtk3'
    depends_on 'sommelier'
  end

  def self.build
    system "echo '#!/bin/bash' > firefox.sh"
    system "echo 'cd #{CREW_PREFIX}/firefox' >> firefox.sh"
    system "echo './firefox \"\$@\"' >> firefox.sh"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/firefox"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/firefox"
    system "install -Dm755 firefox.sh #{CREW_DEST_PREFIX}/bin/firefox"
  end
end
