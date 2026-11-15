require 'buildsystems/cmake'

class Libarchive < CMake
  description 'Multi-format archive and compression library.'
  homepage 'https://www.libarchive.org/'
  version "3.8.11-#{CREW_ICU_VER}"
  license 'BSD, BSD-2, BSD-4 and public-domain'
  compatibility 'all'
  source_url 'https://github.com/libarchive/libarchive.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'adc1c93507b32489c97f43849e15b08a789bec9dced156ee6821051ea9f9d2cd',
     armv7l: 'adc1c93507b32489c97f43849e15b08a789bec9dced156ee6821051ea9f9d2cd',
       i686: '990f11022b86a66f925801114b694df64952065b4c271edb656ce85a2678d726',
     x86_64: '0b30a5d54f31ae69b80f5610b7387ec49d278a91d70d4472d8e1d41d35b74589'
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
