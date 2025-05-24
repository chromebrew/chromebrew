require 'buildsystems/cmake'

class Libarchive < CMake
  description 'Multi-format archive and compression library.'
  homepage 'https://www.libarchive.org/'
  version "3.8.0-#{CREW_ICU_VER}-1"
  license 'BSD, BSD-2, BSD-4 and public-domain'
  compatibility 'all'
  source_url "https://www.libarchive.org/downloads/libarchive-#{version.split('-').first}.tar.xz"
  source_sha256 '67bfac3798a778143f4b1cadcdb3792b4269486f8e1b70ca5c0ee5841398bfdf'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c7207f0c8d0bb8f1a2fa547a80cb6f9a4979850926dfb668b70015f423b913a0',
     armv7l: 'c7207f0c8d0bb8f1a2fa547a80cb6f9a4979850926dfb668b70015f423b913a0',
       i686: '67f2fc8f8d75b5182f7bc11c7ffc1d77103963e97aecdf96e94e4f98773ede2d',
     x86_64: 'e52ad0ab46be7156e831cf8a19628d28a8c9b178c9e2a36223a89d4fd3e60422'
  })

  depends_on 'acl' # R
  depends_on 'attr' # R
  depends_on 'bzip2' # R
  depends_on 'expat' # R
  depends_on 'gcc_lib' => :build
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'libxml2' # R
  depends_on 'lz4' # R
  depends_on 'openssl' # R
  depends_on 'xzutils' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  cmake_options '-DENABLE_TEST=OFF'

  def self.patch
    # Fix LIBDIR being set improperly for cmake. (This was merged after 3.8.0)
    # This needs CMAKE_INSTALL_LIBDIR to be set.
    downloader 'https://github.com/libarchive/libarchive/pull/2509.diff', '355a5c17f91968b14df4b07b944aaf16746a0896ada5ef8653b08930640e01e7'
    system 'patch -Np1 -i 2509.diff'
  end

  cmake_install_extras do
    # As per Arch pkgbuild. This fixes epiphany builds.
    system "sed -i 's/iconv//g' #{CREW_DEST_LIB_PREFIX}/pkgconfig/libarchive.pc"
  end
end
