require 'buildsystems/autotools'

class Mtools < Autotools
  description 'Mtools is a collection of utilities to access MS-DOS disks from GNU and Unix without mounting them.'
  homepage 'https://www.gnu.org/software/mtools/'
  version '4.0.45'
  license 'GPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://ftpmirror.gnu.org/mtools/mtools-#{version}.tar.lz"
  source_sha256 '32ca85dfc1674c536143d4e0da60e3134039eb9552e0fecfa110e9c8736093ce'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '301c1cbc6059963e5275ec7f474a5439acd3fb9c75575d91de6c7451e0d74519',
     armv7l: '301c1cbc6059963e5275ec7f474a5439acd3fb9c75575d91de6c7451e0d74519',
     x86_64: '8444664ab8fa7d98336bd4ac50927d589af516cf4f85e6d33f7ed118eb39ae10'
  })

  configure_options '--without-x'
end
