require 'package'

class Msttcorefonts < Package
  description "An easy way to install Microsoft's TrueType core fonts on Linux"
  homepage 'http://corefonts.sourceforge.net/'
  version '3.6'
  compatibility 'all'
  source_url 'http://http.debian.net/debian/pool/contrib/m/msttcorefonts/msttcorefonts_3.6.tar.gz'
  source_sha256 'c23a2c519acad44fb65dfdd5b6f7de7b351ec15394df52cc744e3c6deb51d42f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/msttcorefonts-3.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/msttcorefonts-3.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/msttcorefonts-3.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/msttcorefonts-3.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f6c8457c11a02cd39c89a35af70038de861610c75dcb6304d7baf0f283306370',
     armv7l: 'f6c8457c11a02cd39c89a35af70038de861610c75dcb6304d7baf0f283306370',
       i686: 'ff4943e48567b37bfb3c871aa458351572016f9f501c789c5d7f8cd4b5db49a7',
     x86_64: 'ce135a84d46fa69fbc29638d389d4ac6cf4fef4b1921f4f9a1497d17d6f4fed7',
  })

  depends_on 'cabextract'

  def self.build
    # Since there is no configure script available, some modifications to prevent a 'file not found'
    # message and writes to read-only directories were necessary in the update-ms-fonts script.
    system "sed -i '61icp cabfiles.sha256sums \$SCRATCHDIR/' update-ms-fonts"
    system "sed -i 's,/var/lib/msttcorefonts/,,g' update-ms-fonts"
    system "sed -i 's,/usr/share,#{CREW_DEST_PREFIX}/share,g' update-ms-fonts"
  end

  def self.install
    system "./update-ms-fonts"
  end

  def self.postinstall
    puts
    puts "Fonts are installed in #{CREW_PREFIX}/share/fonts/truetype/msttcorefonts.".lightblue
    puts
  end
end
