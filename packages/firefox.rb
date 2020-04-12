require 'package'

class Firefox < Package
  description 'Mozilla Firefox (or simply Firefox) is a free and open-source web browser'
  homepage 'https://www.mozilla.org/en-US/firefox/'
  version '75.0'
  case ARCH
  when 'i686'
    source_url 'https://archive.mozilla.org/pub/firefox/releases/75.0/linux-i686/en-US/firefox-75.0.tar.bz2'
    source_sha256 '1ea6efedd36293239a66a91c502ef7b24cccb8fdbde1f72763706f07f99fb057'
  when 'x86_64'
    source_url 'https://archive.mozilla.org/pub/firefox/releases/75.0/linux-x86_64/en-US/firefox-75.0.tar.bz2'
    source_sha256 'c5d9700381c4ad1bde4282735593d5726d9869e3db69ac2e0c24e40597ca4aa6'
  end

  depends_on 'gtk3'
  depends_on 'sommelier'

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
