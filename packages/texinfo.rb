require 'buildsystems/autotools'

class Texinfo < Autotools
  description 'Texinfo is the official documentation format of the GNU project.'
  homepage 'https://www.gnu.org/software/texinfo/'
  version "7.3-#{CREW_PERL_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/texinfo/texinfo-#{version.split('-')[0]}.tar.xz"
  source_sha256 'e085acf253e094f159d7afab18cf740cf7a0c99d18d14c2d45ee221749bddf16'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6a00c0a5514556d1fa56e1e82bb85f2cff9923f7ccebb29e948ec8626f7de2f3',
     armv7l: '6a00c0a5514556d1fa56e1e82bb85f2cff9923f7ccebb29e948ec8626f7de2f3',
       i686: 'b0e4bd189c9c8a23306cc6005788563bc6f3bea5f49166441836988e31ace5b3',
     x86_64: 'a9c4421a7cc4e6a4735d81a7bd74a0a6881ea68ebee4b1013dd2ea165e6eaa96'
  })

  depends_on 'glibc' => :library
  depends_on 'libunistring' => :library
  depends_on 'ncurses' => :executable
  depends_on 'perl' => :logical
  depends_on 'perl_libintl_perl' => :logical
  depends_on 'perl_text_unidecode' => :logical
  depends_on 'perl_unicode_eastasianwidth' => :logical

  autotools_configure_options '--with-external-Text-Unidecode \
    --with-external-Unicode-EastAsianWidth'

  run_tests
end
