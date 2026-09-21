require 'buildsystems/autotools'

class Gzip < Autotools
  description 'GNU Gzip is a popular data compression program originally written by Jean-loup Gailly for the GNU project.'
  homepage 'https://www.gnu.org/software/gzip/'
  version '1.15'
  compatibility 'all'
  license 'GPL-3'
  source_url "https://ftp.gnu.org/gnu/gzip/gzip-#{version}.tar.xz"
  source_sha256 '9aa0cc780dec156b8282844833b342ab7cb08c25d2cd9a1869cdd0df31deff48'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '896303cba73c10a3decf76698703107442501aeb107f490dc3776a3d772c2faa',
     armv7l: '896303cba73c10a3decf76698703107442501aeb107f490dc3776a3d772c2faa',
       i686: '177e708ddf22ddf87af76841a30b2a8d59385b24e7bed8cdc55c0a3bf42b17d4',
     x86_64: '7853b68cd349c842d0c3937d72035c05377085612ece18eaa2be6e74dca03b9c'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  # Tests fail due to tty not being available in the automated build containers.
  # more: Failed to initialize input reader

  autotools_configure_options ('--disable-year2038' if ARCH == 'armv7l').to_s
end
