require 'package'

class Firefox < Package
  description 'Mozilla Firefox (or simply Firefox) is a free and open-source web browser'
  homepage 'https://www.mozilla.org/en-US/firefox/'
  version '73.0.1'
  case ARCH
  when 'i686'
    source_url 'https://archive.mozilla.org/pub/firefox/releases/73.0.1/linux-i686/en-US/firefox-73.0.1.tar.bz2'
    source_sha256 '0cf4ed94739979f5c7fce0a94152911079722cc0118edab9a8f6a573bdf06c3a'
  when 'x86_64'
    source_url 'https://archive.mozilla.org/pub/firefox/releases/73.0.1/linux-x86_64/en-US/firefox-73.0.1.tar.bz2'
    source_sha256 'd5a2c93844763b2e7f7f555eab239b71442cd87205c40a8ad287c38208a2a513'
  end

  depends_on 'gtk3'
  depends_on 'sommelier'

  def self.build
    system "echo '#!/bin/bash' > firefox.sh"
    system "echo 'cd #{CREW_PREFIX}/share/firefox' >> firefox.sh"
    system "echo './firefox \"\$@\"' >> firefox.sh"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/firefox"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/firefox"
    system "install -Dm755 firefox.sh #{CREW_DEST_PREFIX}/bin/firefox"
  end
end
