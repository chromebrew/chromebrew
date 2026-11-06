require 'buildsystems/autotools'

class Libiconv < Autotools
  description 'GNU charset conversion library for libc which does not implement it.'
  homepage 'https://www.gnu.org/software/libiconv/'
  version '1.19.1'
  license 'LGPL-2+ and GPL-3+'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/libiconv/libiconv-#{version}.tar.gz"
  source_sha256 '9a06844846d664d7122161700c10a64480d7c7bcead3091925a785b38c91edab'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '52203a27db6ca9f3d03e15d7ea19a511d19e1c369dd900dbec105064ac5b3fe4',
     armv7l: '52203a27db6ca9f3d03e15d7ea19a511d19e1c369dd900dbec105064ac5b3fe4',
       i686: '8a4d58ae8958773b4a688ce1849fc1881f61c78dfe14810fdff50005959b2517',
     x86_64: '74b73e2a81cf0c739af39b1c29b4c157e814eee5473b503fd9ce9ce841207fef'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  autotools_skip_autogen
  autotools_skip_autoreconf

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
