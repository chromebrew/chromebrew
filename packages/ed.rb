require 'buildsystems/autotools'

class Ed < Autotools
  description 'GNU ed is a line-oriented text editor.'
  homepage 'http://www.gnu.org/software/ed/ed.html'
  version '1.22.5'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/ed/ed-#{version}.tar.lz"
  source_sha256 '56e107ddc2f29dad6690376c15bf9751509e1ee3b8241710e44edbe5c3a158cc'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7191a1f8ade2fc029dc0d82783dbcbc2e6176af3cd779756c21e10ca32cd146f',
     armv7l: '7191a1f8ade2fc029dc0d82783dbcbc2e6176af3cd779756c21e10ca32cd146f',
       i686: 'e97ac61ce4cdc2ab518ae2ddd8932500c089e48a8c10f757c456dd2fa7989d3b',
     x86_64: 'b85eb1539017207621a2f6361c760738c1f965889f2691e711a13574f5528925'
  })

  # only lz archive is available for ed and it requires lzip.
  depends_on 'lzip' => :build
end
