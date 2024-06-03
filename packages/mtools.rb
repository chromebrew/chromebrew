require 'buildsystems/autotools'

class Mtools < Autotools
  description 'Mtools is a collection of utilities to access MS-DOS disks from GNU and Unix without mounting them.'
  homepage 'https://www.gnu.org/software/mtools/'
  version '4.0.44'
  license 'GPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://ftpmirror.gnu.org/mtools/mtools-#{version}.tar.lz"
  source_sha256 'e9cd7fff9e107b69a57bcbd59e9ccd76448cd5db0194a2383757e421994b21d7'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '394a41b3f8c5a8802d3f4daf150764bdfa25b62617144857d95be1b306c5b977',
     armv7l: '394a41b3f8c5a8802d3f4daf150764bdfa25b62617144857d95be1b306c5b977',
     x86_64: 'ec2796ea1ad06799acc17a0367a4c37a946423e10742ef7ce44acd3b6e4aff41'
  })

  configure_options '--without-x'
end
