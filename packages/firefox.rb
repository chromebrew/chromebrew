require 'package'

class Firefox < Package
  description 'Mozilla Firefox (or simply Firefox) is a free and open-source web browser'
  homepage 'https://www.mozilla.org/en-US/firefox/'
  version '85.0.2'
  compatibility 'i686,x86_64'
  case ARCH
  when 'i686'
    source_url "https://archive.mozilla.org/pub/firefox/releases/#{version}/linux-i686/en-US/firefox-#{version}.tar.bz2"
    source_sha256 '83ace0384a14e383e65716ef9305d72e39832b855ebecf2035e6267b4c9a97a5'
  when 'x86_64'
    source_url "https://archive.mozilla.org/pub/firefox/releases/#{version}/linux-x86_64/en-US/firefox-#{version}.tar.bz2"
    source_sha256 '98763f4b1526811967d71e1bbb9552a9a3fd877321ecb497083b9e313b528c31'
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
