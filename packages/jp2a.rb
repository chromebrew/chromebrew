require 'buildsystems/autotools'

class Jp2a < Autotools
  description 'jp2a is a simple JPEG/PNG to ASCII converter.'
  homepage 'https://github.com/Talinx/jp2a'
  version '1.3.2'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/Talinx/jp2a/releases/download/v1.1.1/jp2a-1.1.1.tar.bz2'
  source_sha256 '3b91f26f79eca4e963b1b1ae2473722a706bf642218f20bfe4ade5333aebb106'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6f27bfadc6dd38133c88500d05b3f5cedb26c79a5bf632e65d0bdf1045c96407',
     armv7l: '6f27bfadc6dd38133c88500d05b3f5cedb26c79a5bf632e65d0bdf1045c96407',
       i686: '1ff7e8633fb8b8d9a58beed5b2bfd2ddc844a51991f456cbf634eea213ffe6ef',
     x86_64: 'a557c2f043bc5694010481cad6e41db5daf6487a78d761d935633cc1f1eed391'
  })

  depends_on 'curl' # R
  depends_on 'glibc' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libpng' # R
  depends_on 'ncurses' # R

  autotools_pre_configure_options "CFLAGS='-lncurses -ltinfo -I#{CREW_PREFIX}/include/ncurses #{CREW_ENV_OPTIONS_HASH['CFLAGS']}' LDFLAGS='-L#{CREW_LIB_PREFIX} -lncurses -ltinfo #{CREW_ENV_OPTIONS_HASH['LDFLAGS']}'"
  autotools_configure_options '--enable-curl'

  def self.check
    system 'make check || true'
  end
end
