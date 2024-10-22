require 'buildsystems/autotools'

class Exo < Autotools
  description 'Extension library for the Xfce desktop environment'
  homepage 'https://xfce.org/'
  version '4.19.0'
  license 'Apache-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://archive.xfce.org/src/xfce/exo/#{version.rpartition('.')[0]}/exo-#{version}.tar.bz2"
  source_sha256 'a0124108c197efcc576a6deeface381416dc7137b6a7e7dfa3060fad62509fb7'
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
