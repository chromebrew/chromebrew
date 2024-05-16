require 'buildsystems/autotools'

class A2ps < Autotools
  description 'GNU a2ps is an Any to PostScript filter.'
  homepage 'https://www.gnu.org/software/a2ps/'
  version '4.15.6'
  license 'GPL-3'
  # Builds are currently broken on i686: https://savannah.gnu.org/bugs/?65903
  compatibility 'aarch64 armv7l x86_64'
  # Bootstrapping from git fails: https://savannah.gnu.org/bugs/index.php?65830
  source_url 'https://ftpmirror.gnu.org/a2ps/a2ps-4.15.6.tar.gz'
  source_sha256 '87ff9d801cb11969181d5b8cf8b65e65e5b24bb0c76a1b825e8098f2906fbdf4'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ebecfeff108d16f671271dadcb423d43f5342c2a19fd705ff18e38673de86d32',
     armv7l: 'ebecfeff108d16f671271dadcb423d43f5342c2a19fd705ff18e38673de86d32',
     x86_64: '1e7a0c86ad72bbddcbcb85e01d3d848109ddc9e5680004206a2fc5428d0e261c'
  })

  depends_on 'bdwgc'
  depends_on 'libpaper'
  depends_on 'py3_pspdfutils'

  run_tests
end
