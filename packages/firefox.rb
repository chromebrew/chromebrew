require 'package'

class Firefox < Package
  description 'Mozilla Firefox (or simply Firefox) is a free and open-source web browser'
  homepage 'https://www.mozilla.org/en-US/firefox/'
  version '70.0.1'
  case ARCH
  when 'x86_64'
    source_url 'https://archive.mozilla.org/pub/firefox/releases/70.0.1/linux-x86_64/en-US/firefox-70.0.1.tar.bz2'
    source_sha256 'bc1ef29799f15d1fe709a430203d16c12d5ae0899f1c01ba4461062392a2e77e'
  when 'i686'
    source_url 'https://archive.mozilla.org/pub/firefox/releases/70.0.1/linux-i686/en-US/firefox-70.0.1.tar.bz2'
    source_sha256 '4981bae093177f3ae705bbf9119a2e9149dbfa3d931157a724fb1b294c099811'
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
    FileUtils.cp_r Dir.glob('*'), "#{CREW_DEST_PREFIX}/share/firefox"
    system "install -Dm755 firefox.sh #{CREW_DEST_PREFIX}/bin/firefox"
  end
end
