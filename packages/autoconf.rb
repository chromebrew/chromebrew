require 'buildsystems/autotools'

class Autoconf < Autotools
  description 'Autoconf is an extensible package of M4 macros that produce shell scripts to automatically configure software source code packages.'
  homepage 'http://www.gnu.org/software/autoconf/'
  version '2.73'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/autoconf/autoconf-#{version}.tar.xz"
  source_sha256 '9fd672b1c8425fac2fa67fa0477b990987268b90ff36d5f016dae57be0d6b52e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f1c21e1308541d975aade2765e1c4de0915e5379d95063ab3bfff5e2d375235d',
     armv7l: 'f1c21e1308541d975aade2765e1c4de0915e5379d95063ab3bfff5e2d375235d',
       i686: '734f0136c2a05a25f6baf61e910a8272adfc10bfde1fa433bfdc5443e16b5810',
     x86_64: 'cc174c528c7e92259703857f2c77faa4826a274bf02f9d062c648a3562f8bc91'
  })

  depends_on 'perl'
  depends_on 'm4'
end
