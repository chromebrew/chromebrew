require 'buildsystems/autotools'

class Libiconv < Autotools
  description 'GNU charset conversion library for libc which does not implement it.'
  homepage 'https://www.gnu.org/software/libiconv/'
  version '1.18'
  license 'LGPL-2+ and GPL-3+'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/libiconv/libiconv-#{version}.tar.gz"
  source_sha256 '3b08f5f4f9b4eb82f151a7040bfd6fe6c6fb922efe4b1659c66ea933276965e8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '641ca4cfd2a72330fa741c17b3bf657db3a688ed097cf75c1a1a0c3fe04b56dc',
     armv7l: '641ca4cfd2a72330fa741c17b3bf657db3a688ed097cf75c1a1a0c3fe04b56dc',
       i686: 'd4f65cc6d4a00b825003fc05a2eb847fb650d85d8b9b19094d7cd990055ec464',
     x86_64: '5b6dea457a565ee6fca3346a74d2aab7241c9556a2afab3bcb2accb589d6da92'
  })

  depends_on 'glibc' # R

  autotools_configure_options "--includedir=#{CREW_PREFIX}/include/gnu-libiconv \
        --enable-static \
        --enable-relocatable \
        --enable-extra-encodings"

  autotools_install_extras do
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/iconv", "#{CREW_DEST_PREFIX}/bin/gnu-libiconv-iconv"
    FileUtils.mv "#{CREW_DEST_MAN_PREFIX}/man3/iconv_close.3", "#{CREW_DEST_MAN_PREFIX}/man3/gnu-libiconv-iconv_close.3"
    FileUtils.mv "#{CREW_DEST_MAN_PREFIX}/man3/iconv.3", "#{CREW_DEST_MAN_PREFIX}/man3/gnu-libiconv-iconv.3"
    FileUtils.mv "#{CREW_DEST_MAN_PREFIX}/man3/iconv_open.3", "#{CREW_DEST_MAN_PREFIX}/man3/gnu-libiconv-iconv_open.3"
    FileUtils.mv "#{CREW_DEST_MAN_PREFIX}/man1/iconv.1", "#{CREW_DEST_MAN_PREFIX}/man1/gnu-libiconv-iconv.1"
    # Header files are moved to #{CREW_PREFIX}/include/gnu-libiconv
    # to avoid conflict with versions from glibc
  end
end
