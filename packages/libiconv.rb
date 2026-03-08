require 'buildsystems/autotools'

class Libiconv < Autotools
  description 'GNU charset conversion library for libc which does not implement it.'
  homepage 'https://www.gnu.org/software/libiconv/'
  version '1.19'
  license 'LGPL-2+ and GPL-3+'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/libiconv/libiconv-#{version}.tar.gz"
  source_sha256 '88dd96a8c0464eca144fc791ae60cd31cd8ee78321e67397e25fc095c4a19aa6'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ef74c65f179c2bc2a915b1bf0dc55d69f202bccdd58b4f3a44e3f0fc06e6de18',
     armv7l: 'ef74c65f179c2bc2a915b1bf0dc55d69f202bccdd58b4f3a44e3f0fc06e6de18',
       i686: '80406266295b5bffd5a891daa2df1a258ccf82f33cf6934f18c24d1d94844231',
     x86_64: 'fe48380945f08a4f391dc38dcdc9ec4774c22ff68fdd415be73b76873b87f86a'
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
