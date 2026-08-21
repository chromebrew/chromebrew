require 'buildsystems/autotools'

class Ed < Autotools
  description 'GNU ed is a line-oriented text editor.'
  homepage 'http://www.gnu.org/software/ed/ed.html'
  version '1.22.6'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/ed/ed-#{version}.tar.lz"
  source_sha256 '3f33b22135219c39c3c695f7b7171c2567d3e2a17c798c0a90607320cbb268f2'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '07ed27b1eebe06ca9e12a95924fa01a70518bb6f79e5c6fe98ff7558bcb20768',
     armv7l: '07ed27b1eebe06ca9e12a95924fa01a70518bb6f79e5c6fe98ff7558bcb20768',
       i686: '082f377693ffd42a5dc4c5edb3ba68f544fa21a0deef0a2df9662c4a1c450bdf',
     x86_64: '186637f055316add7a42ae455abfdc73b50990308d097d8d0386ff28cd342a1f'
  })

  # only lz archive is available for ed and it requires lzip.
  depends_on 'glibc' => :executable
  depends_on 'lzip' => :build
end
