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
    aarch64: 'd688b659e5435fa2443075772311086bc430bccfafa77e7889746a343357b90d',
     armv7l: 'd688b659e5435fa2443075772311086bc430bccfafa77e7889746a343357b90d',
       i686: '1d9cdfca3f904b469bf58ba2df36e921064274a23da3fbc1599f0ba63e570dd2',
     x86_64: '1de35f406639130b9b43795ff03223e0e5d78ccea3ed1ec36f28812537a692c9'
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
