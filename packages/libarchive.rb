require 'buildsystems/cmake'

class Libarchive < CMake
  description 'Multi-format archive and compression library.'
  homepage 'https://www.libarchive.org/'
  version "3.8.10-#{CREW_ICU_VER}"
  license 'BSD, BSD-2, BSD-4 and public-domain'
  compatibility 'all'
  source_url 'https://github.com/libarchive/libarchive.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '63fe64e4dcf96d979e9817e551563023fd01d70ff7f151839689c633e85b2365',
     armv7l: '63fe64e4dcf96d979e9817e551563023fd01d70ff7f151839689c633e85b2365',
       i686: '564a9b9834f9ea9b12953af9290d048a25216996bcdd7343fba7e63d03a30183',
     x86_64: '11a87f97e5b06d32a9f83af523a742dc4db7fceb6b4c00e03cd47dc6b7c1dca1'
  })

  depends_on 'acl' => :library
  depends_on 'attr' # R
  depends_on 'bzip2' => :library
  depends_on 'expat' # R
  depends_on 'gcc_lib' => :build
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'icu4c' # R
  depends_on 'libiconv' => :library
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

  def self.patch
    patches = [
      # Fix for https://github.com/libarchive/libarchive/issues/3338
      ['https://github.com/libarchive/libarchive/pull/3339.patch', '423847f4e448361cae1d86a2ab62e47b3cd31b76a065294ff9b2e5a689ec9cbd']
    ]
    ConvenienceFunctions.patch(patches) if version.split('-').first.eql?('3.8.9')
  end
end
