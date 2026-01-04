require 'buildsystems/autotools'

class Ddrescue < Autotools
  description 'GNU ddrescue is a data recovery tool.'
  homepage 'https://www.gnu.org/software/ddrescue/'
  version '1.30'
  license 'GPL-2+'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/ddrescue/ddrescue-#{version}.tar.lz"
  source_sha256 '2264622d309d6c87a1cfc19148292b8859a688e9bc02d4702f5cd4f288745542'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ed4c1191de356867b8610cf268b7f433485d9c3f3174f7b1ff540cc9520fee33',
     armv7l: 'ed4c1191de356867b8610cf268b7f433485d9c3f3174f7b1ff540cc9520fee33',
       i686: '7c3fea6fc14acc04a9365c3fd6822ee976924f9bedea30689cc68b30189f37bc',
     x86_64: 'b50c0c067e4ecbc84a9386351e1d281c7cffdb4ab3e2667c2087eafa7f951059'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  autotools_configure_options '--enable-non-posix'
end
