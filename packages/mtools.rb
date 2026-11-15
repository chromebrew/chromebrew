require 'buildsystems/autotools'

class Mtools < Autotools
  description 'Mtools is a collection of utilities to access MS-DOS disks from GNU and Unix without mounting them.'
  homepage 'https://www.gnu.org/software/mtools/'
  version '4.0.50'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://ftp.gnu.org/gnu/mtools/mtools-#{version}.tar.lz"
  source_sha256 '6adccaf371081efb6cf2fe687c88746c0978bafeb9deed5c2b03992704a1a6ab'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '046f927e02175ecc4eafd6ccb9f7a81d8a5d37d90b992a0ad659094393b3600d',
     armv7l: '046f927e02175ecc4eafd6ccb9f7a81d8a5d37d90b992a0ad659094393b3600d',
     x86_64: '2202e3d57b1c2b81e78125b4786d5932117f3f4a305838f30984e79ddd829cce'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libiconv' => :executable

  autotools_configure_options '--without-x'
end
