require 'package'

class Firefox_esr < Package
  description 'Mozilla Firefox (or simply Firefox) is a free and open-source web browser. Extended Standard Release version.'
  homepage 'https://www.mozilla.org/en-US/firefox/enterprise/'
  version '78.7.1esr'
  compatibility 'i686,x86_64'
  case ARCH
  when 'i686'
    source_url "https://archive.mozilla.org/pub/firefox/releases/#{version}/linux-i686/en-US/firefox-#{version}.tar.bz2"
    source_sha256 '11aca3b298c87e785bde900c1c346a7dca4a33d40633dfb71d267bd9b79f0451'
  when 'x86_64'
    source_url "https://archive.mozilla.org/pub/firefox/releases/#{version}/linux-x86_64/en-US/firefox-#{version}.tar.bz2"
    source_sha256 '2d16c787ccce51f4dede9ef72d1ea33b5d220a6ae2e313bfb7fe8af2b1f0a336'
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
