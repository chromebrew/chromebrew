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
    aarch64: 'c6e4af9027eb49b2ceda1dda776aade7e81a8cfb0acf3a1795613abb610d1271',
     armv7l: 'c6e4af9027eb49b2ceda1dda776aade7e81a8cfb0acf3a1795613abb610d1271',
       i686: 'c7da365ba4cf47729ab799f772e325d98fa99c2fbf49b99036dca6bd49c14271',
     x86_64: '4a3c77f78e3fa701a98ec4190578e27ff95112719db03be10fbdfff01cb49628'
  })

  depends_on 'acl' => :library
  depends_on 'attr' # R
  depends_on 'bzip2' => :library
  depends_on 'expat' # R
  depends_on 'gcc_lib' => :build
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
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
