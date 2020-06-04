require 'package'

class Firefox < Package
  description 'Mozilla Firefox (or simply Firefox) is a free and open-source web browser'
  homepage 'https://www.mozilla.org/en-US/firefox/'
  version '77.0.1'
  case ARCH
  when 'i686'
    source_url 'https://archive.mozilla.org/pub/firefox/releases/77.0.1/linux-i686/en-US/firefox-77.0.1.tar.bz2'
    source_sha256 '11db2f7c5aa0bf534e915a9cb380a1bb26656d92321a762597da619fbf84e120'
  when 'x86_64'
    source_url 'https://archive.mozilla.org/pub/firefox/releases/77.0.1/linux-x86_64/en-US/firefox-77.0.1.tar.bz2'
    source_sha256 '03859fd56f79cb520e30bae2433b6f61f806c8f95e7576092894eb1d644e6ff1'
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
