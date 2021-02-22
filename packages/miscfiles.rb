require 'package'

class Miscfiles < Package
  description 'A collection of files not of crucial importance for system administration or operation, but which have come to be common on various systems over the years.'
  homepage 'https://www.gnu.org/software/miscfiles/'
  version '1.5'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/miscfiles/miscfiles-1.5.tar.gz'
  source_sha256 '6aaaa8898b0f6dac18bcaa5492874a6cd1243ffbe7a6dd347ca8f3ec3642a500'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/miscfiles-1.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/miscfiles-1.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/miscfiles-1.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/miscfiles-1.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '83434d1f24d47b5e86b7ab649f186ab02530ac3a11c2f3cbf77481a95e3e2e0b',
     armv7l: '83434d1f24d47b5e86b7ab649f186ab02530ac3a11c2f3cbf77481a95e3e2e0b',
       i686: 'b9907e7bb95ca4501697ca6b376eba5001d1ac5f384f424fa54ae3da6491255f',
     x86_64: 'dbf2dfd4a5ee2268712620c434e3d97a4165d5ab2ab3170a467850cb5ddba59b',
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
