require 'buildsystems/cmake'

class Zlib < CMake
  description 'zlib is a massively spiffy yet delicately unobtrusive compression library.'
  homepage 'https://www.zlib.net'
  version '1.3.2' # Do not use @_ver here, it will break the installer.
  # When upgrading zlib, be sure to upgrade minizip in tandem.
  # The following breaks the installer script.
  # puts "#{self} version differs from Minizip version #{Minizip.version}".orange if @_ver != Minizip.version
  license 'zlib'
  compatibility 'all'
  source_url "https://www.zlib.net/zlib-#{version}.tar.gz"
  source_sha256 'bb329a0a2cd0274d05519d61c667c062e06990d72e125ee2dfa8de64f0119d16'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '26aa5e640e2da1feb28f5b18e5897f1a5124dcdc2091a126836b520ab210312c',
     armv7l: '26aa5e640e2da1feb28f5b18e5897f1a5124dcdc2091a126836b520ab210312c',
       i686: 'dd1167ab9dec26ae6429cfe3035c9ae8569b51add890b387b677ec661c5174bd',
     x86_64: 'eb8dcb63a7b08dcedb52e8aa19a100ac4c0c45e0b1b3945d45538485cb6093f3'
  })

  depends_on 'glibc' => :library

  cmake_options "#{CREW_CMAKE_OPTIONS.gsub('-mfpu=vfpv3-d16', '-mfpu=neon-fp16')} -Wno-dev"

  run_tests

  def self.patch
    system "sed -i 's,CMAKE_INSTALL_PREFIX}/lib,CMAKE_INSTALL_PREFIX}/#{ARCH_LIB},g' CMakeLists.txt"
    system "sed -i 's,CMAKE_INSTALL_PREFIX}/share/pkgconfig,CMAKE_INSTALL_PREFIX}/#{ARCH_LIB}/pkgconfig,g' CMakeLists.txt"
  end
end
