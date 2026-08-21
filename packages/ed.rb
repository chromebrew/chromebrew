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
    aarch64: '666055709189337246f421132d582a17aced4aa3389420721472b127feb49eaf',
     armv7l: '666055709189337246f421132d582a17aced4aa3389420721472b127feb49eaf',
       i686: '1fe418e4f051814f5c606c603dc503f6a52ee3487e2b5bd0c7a46e6bb637b36e',
     x86_64: '05f033d773e4d0e5bdcfea0f0584883aa2e090f6673a2cb15124c980207b6f37'
  })

  # only lz archive is available for ed and it requires lzip.
  depends_on 'glibc' => :executable
  depends_on 'lzip' => :build
end
