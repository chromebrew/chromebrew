require 'package'

class Libiconv < Package
  description 'GNU charset conversion library for libc which does not implement it.'
  homepage 'https://www.gnu.org/software/libiconv/'
  version '1.17'
  license 'LGPL-2+ and GPL-3+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/libiconv/libiconv-1.17.tar.gz'
  source_sha256 '8f74213b56238c85a50a5329f77e06198771e70dd9a739779f4c02f65d971313'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libiconv/1.17_armv7l/libiconv-1.17-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libiconv/1.17_armv7l/libiconv-1.17-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libiconv/1.17_i686/libiconv-1.17-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libiconv/1.17_x86_64/libiconv-1.17-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '641ca4cfd2a72330fa741c17b3bf657db3a688ed097cf75c1a1a0c3fe04b56dc',
     armv7l: '641ca4cfd2a72330fa741c17b3bf657db3a688ed097cf75c1a1a0c3fe04b56dc',
       i686: 'd4f65cc6d4a00b825003fc05a2eb847fb650d85d8b9b19094d7cd990055ec464',
     x86_64: '5b6dea457a565ee6fca3346a74d2aab7241c9556a2afab3bcb2accb589d6da92'
  })

  def self.build
    system "./configure #{CREW_OPTIONS} \
        --includedir=#{CREW_PREFIX}/include/gnu-libiconv \
        --enable-static \
        --enable-relocatable \
        --enable-extra-encodings"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/iconv", "#{CREW_DEST_PREFIX}/bin/gnu-libiconv-iconv"
    FileUtils.mv "#{CREW_DEST_MAN_PREFIX}/man3/iconv_close.3", "#{CREW_DEST_MAN_PREFIX}/man3/gnu-libiconv-iconv_close.3"
    FileUtils.mv "#{CREW_DEST_MAN_PREFIX}/man3/iconv.3", "#{CREW_DEST_MAN_PREFIX}/man3/gnu-libiconv-iconv.3"
    FileUtils.mv "#{CREW_DEST_MAN_PREFIX}/man3/iconv_open.3", "#{CREW_DEST_MAN_PREFIX}/man3/gnu-libiconv-iconv_open.3"
    FileUtils.mv "#{CREW_DEST_MAN_PREFIX}/man1/iconv.1", "#{CREW_DEST_MAN_PREFIX}/man1/gnu-libiconv-iconv.1"
    # Header files are moved to #{CREW_PREFIX}/include/gnu-libiconv
    # to avoid conflict with versions from glibc
  end
end
