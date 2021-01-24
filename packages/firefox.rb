require 'package'

class Firefox < Package
  description 'Mozilla Firefox (or simply Firefox) is a free and open-source web browser'
  homepage 'https://www.mozilla.org/en-US/firefox/'
  version '84.0'
  compatibility 'i686,x86_64'
  case ARCH
  when 'i686'
    source_url 'https://archive.mozilla.org/pub/firefox/releases/84.0/linux-i686/en-US/firefox-84.0.tar.bz2'
    source_sha256 '011598d4ccaccf87b9dd655ca266805378d5fcfd87fd9213ae4d5be9dee56278'
  when 'x86_64'
    source_url 'https://archive.mozilla.org/pub/firefox/releases/84.0/linux-x86_64/en-US/firefox-84.0.tar.bz2'
    source_sha256 '601e5a9a12ce680ecd82177c7887dae008d8f33690da43be1a690b76563cd992'
  end

  case ARCH
  when 'i686', 'x86_64'
    depends_on 'gtk3'
    depends_on 'apulse'
    depends_on 'sommelier'
  end

# To get sound working, used : https://codelab.wordpress.com/2017/12/11/firefox-drops-alsa-apulse-to-the-rescue/

  def self.build
    system "echo '#!/bin/bash' > firefox.sh"
    system "echo 'cd #{CREW_PREFIX}/firefox' >> firefox.sh"
    system "echo 'apulse ./firefox \"\$@\"' >> firefox.sh"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/firefox"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/firefox"
    system "install -Dm755 firefox.sh #{CREW_DEST_PREFIX}/bin/firefox"
  end
end
