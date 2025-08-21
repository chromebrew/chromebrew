require 'buildsystems/autotools'

class Exo < Autotools
  description 'Extension library for the Xfce desktop environment'
  homepage 'https://xfce.org/'
  version '4.20.0'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://archive.xfce.org/src/xfce/exo/#{version.rpartition('.')[0]}/exo-#{version}.tar.bz2"
  source_sha256 '4277f799245f1efde01cd917fd538ba6b12cf91c9f8a73fe2035fd5456ec078d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '89e5a94b33a630e03eeb5d9e748f71b9ee27001b7b749b2cc765b441ff48f999',
     armv7l: '89e5a94b33a630e03eeb5d9e748f71b9ee27001b7b749b2cc765b441ff48f999',
     x86_64: '4aa61da36edd80c5d36e94c34b610b9dcd41747acfca85d6834041c84eb04c9b'
  })

  depends_on 'libxfce4ui'
  depends_on 'xfce4_dev_tools'
  depends_on 'valgrind' => :build

  run_tests
end
