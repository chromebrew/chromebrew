require 'buildsystems/cmake'

class Libarchive < CMake
  description 'Multi-format archive and compression library.'
  homepage 'https://www.libarchive.org/'
  version "3.8.8-#{CREW_ICU_VER}"
  license 'BSD, BSD-2, BSD-4 and public-domain'
  compatibility 'all'
  source_url 'https://github.com/libarchive/libarchive.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '06dc0de7da751898b5b6da0325de779c1077b5fdf13ef8daf9fff89178f4e292',
     armv7l: '06dc0de7da751898b5b6da0325de779c1077b5fdf13ef8daf9fff89178f4e292',
       i686: '295e8d2b146f1ca8ed1e48d8979c153b710fa83c6f5af197b053af46a405796e',
     x86_64: 'a4faa2cc8f9f3b6590d765a001c5bd04bf738ddef65281018cbf5a7835c91eaa'
  })

  depends_on 'acl' => :library
  depends_on 'attr' # R
  depends_on 'bzip2' => :library
  depends_on 'expat' # R
  depends_on 'gcc_lib' => :build
  depends_on 'glibc' => :library
  depends_on 'icu4c' # R
  depends_on 'libxml2' => :library
  depends_on 'lz4' => :library
  depends_on 'openssl' => :library
  depends_on 'xzutils' => :library
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library

  cmake_options '-DENABLE_TEST=OFF'

  cmake_install_extras do
    # As per Arch pkgbuild. This fixes epiphany builds.
    system "sed -i 's/iconv//g' #{CREW_DEST_LIB_PREFIX}/pkgconfig/libarchive.pc"
  end
end
