require 'buildsystems/cmake'

class Libarchive < CMake
  description 'Multi-format archive and compression library.'
  homepage 'https://www.libarchive.org/'
  version "3.8.5-#{CREW_ICU_VER}"
  license 'BSD, BSD-2, BSD-4 and public-domain'
  compatibility 'all'
  source_url "https://www.libarchive.org/downloads/libarchive-#{version.split('-').first}.tar.xz"
  source_sha256 'd68068e74beee3a0ec0dd04aee9037d5757fcc651591a6dcf1b6d542fb15a703'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b461ae311c5acd928d1c873780472910a62826b9fecf810edbcb73d3e4af5e7c',
     armv7l: 'b461ae311c5acd928d1c873780472910a62826b9fecf810edbcb73d3e4af5e7c',
       i686: '35b4b60222e05542a68f1cbdb8053dba0738a6a1e23b491ba64a781cd9156248',
     x86_64: '9893381c3d4b01359004d9992a17e42b15f978947ba9da1b560db097775bbce1'
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

  cmake_install_extras do
    # As per Arch pkgbuild. This fixes epiphany builds.
    system "sed -i 's/iconv//g' #{CREW_DEST_LIB_PREFIX}/pkgconfig/libarchive.pc"
  end
end
