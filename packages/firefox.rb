require 'package'

class Firefox < Package
  description 'Mozilla Firefox (or simply Firefox) is a free and open-source web browser'
  homepage 'https://www.mozilla.org/en-US/firefox/'
  version '76.0.1'
  case ARCH
  when 'i686'
    source_url 'https://archive.mozilla.org/pub/firefox/releases/76.0.1/linux-i686/en-US/firefox-76.0.1.tar.bz2'
    source_sha256 'f355704f2ccd0bfca2b6de07613262272f37a03b90948e9d6bd5024079819004'
  when 'x86_64'
    source_url 'https://archive.mozilla.org/pub/firefox/releases/76.0.1/linux-x86_64/en-US/firefox-76.0.1.tar.bz2'
    source_sha256 '315faf03a9a06ff561c3d911100739eedeb9f02a7861cbc4613177a072df45ca'
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
