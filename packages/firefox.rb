require 'package'

class Firefox < Package
  description 'Mozilla Firefox (or simply Firefox) is a free and open-source web browser'
  homepage 'https://www.mozilla.org/en-US/firefox/'
  version '81.0.1'
  compatibility 'i686,x86_64'
  case ARCH
  when 'i686'
    source_url 'https://archive.mozilla.org/pub/firefox/releases/81.0.1/linux-i686/en-US/firefox-81.0.1.tar.bz2'
    source_sha256 'bcb562cb3a367c32710c2c19abaf63ad68846b9892795bf89592b879def917af'
  when 'x86_64'
    source_url 'https://archive.mozilla.org/pub/firefox/releases/81.0.1/linux-x86_64/en-US/firefox-81.0.1.tar.bz2'
    source_sha256 '7882ce6ece0b1aeb497d68e8aeff2c58eb5a926fb5003472db493c863e3129f9'
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
