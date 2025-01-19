require 'buildsystems/autotools'

class Mtools < Autotools
  description 'Mtools is a collection of utilities to access MS-DOS disks from GNU and Unix without mounting them.'
  homepage 'https://www.gnu.org/software/mtools/'
  version '4.0.47'
  license 'GPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://ftpmirror.gnu.org/mtools/mtools-#{version}.tar.lz"
  source_sha256 '32ca85dfc1674c536143d4e0da60e3134039eb9552e0fecfa110e9c8736093ce'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '301c1cbc6059963e5275ec7f474a5439acd3fb9c75575d91de6c7451e0d74519',
     armv7l: '301c1cbc6059963e5275ec7f474a5439acd3fb9c75575d91de6c7451e0d74519',
     x86_64: 'e469d2c99cdcc1757492b67032f60eeac0a21f622f46620c9234da13f2d616b3'
  })

  depends_on 'glibc' # R

  configure_options '--without-x'
end
