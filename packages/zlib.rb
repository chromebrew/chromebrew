require 'buildsystems/cmake'

class Zlib < CMake
  description 'zlib is a massively spiffy yet delicately unobtrusive compression library.'
  homepage 'https://zlib.net'
  version '1.3.1-3' # Do not use @_ver here, it will break the installer.
  # When upgrading zlib, be sure to upgrade minizip in tandem.
  # The following breaks the installer script.
  # puts "#{self} version differs from Minizip version #{Minizip.version}".orange if @_ver != Minizip.version
  license 'zlib'
  compatibility 'all'
  source_url "https://www.zlib.net/zlib-#{version.split('-').first}.tar.gz"
  source_sha256 '9a93b2b7dfdac77ceba5a558a580e74667dd6fede4585b91eefb60f03b72df23'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '91195628001afc8a237774386e6ca494fa820f073985355544a0bb177389d7aa',
     armv7l: '91195628001afc8a237774386e6ca494fa820f073985355544a0bb177389d7aa',
       i686: '463a48ec367bc9920178643139a3eabe3c648ed513f35c18c5e28ea5040f664b',
     x86_64: 'dde89b4ba95675c8e3fa91123f6c5b35712571970b5ddcae6f3d25d25162b1b2'
  })

  depends_on 'glibc' # R

  cmake_options "#{CREW_CMAKE_OPTIONS.gsub('-mfpu=vfpv3-d16', '-mfpu=neon-fp16')} -Wno-dev"

  run_tests

  def self.patch
    system "sed -i 's,CMAKE_INSTALL_PREFIX}/lib,CMAKE_INSTALL_PREFIX}/#{ARCH_LIB},g' CMakeLists.txt"
    system "sed -i 's,CMAKE_INSTALL_PREFIX}/share/pkgconfig,CMAKE_INSTALL_PREFIX}/#{ARCH_LIB}/pkgconfig,g' CMakeLists.txt"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    # Remove static library.
    FileUtils.rm "#{CREW_DEST_LIB_PREFIX}/libz.a"
  end
end
