require 'buildsystems/autotools'

class Mtools < Autotools
  description 'Mtools is a collection of utilities to access MS-DOS disks from GNU and Unix without mounting them.'
  homepage 'https://www.gnu.org/software/mtools/'
  version '4.0.49'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://ftpmirror.gnu.org/mtools/mtools-#{version}.tar.lz"
  source_sha256 '32ca85dfc1674c536143d4e0da60e3134039eb9552e0fecfa110e9c8736093ce'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4782d387473bb5f49ee14aaedfeda9579e3b22479b20f9b9d33b05dce86a78fe',
     armv7l: '4782d387473bb5f49ee14aaedfeda9579e3b22479b20f9b9d33b05dce86a78fe',
     x86_64: '649e44c6ae13ab3834149702d321a6f23c09abcb49c703a6bf36420e99e652ad'
  })

  depends_on 'glibc' # R

  autotools_configure_options '--without-x'
end
