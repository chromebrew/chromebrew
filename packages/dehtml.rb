require 'buildsystems/autotools'

class Dehtml < Autotools
  description 'Dehtml removes HTML constructs from documents for indexing, spell checking and so on.'
  homepage 'http://www.moria.de/~michael/dehtml/'
  version '1.8'
  license 'GPL-2+'
  compatibility 'all'
  source_url "http://www.moria.de/~michael/dehtml/dehtml-#{version}.tar.gz"
  source_sha256 'a00e86643b0aa73861e9d8d619a80370f0f99519d34ce12459fab77f5f6b5bde'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd443a2fbbc3d16fdcefce0e8910bd20a230ecce4aeea3cf4aa6a811cd76c3ed1',
     armv7l: 'd443a2fbbc3d16fdcefce0e8910bd20a230ecce4aeea3cf4aa6a811cd76c3ed1',
       i686: 'ead0e0cc2d7a9486ccb8d7a0a0f4b19cdb71f3081df2e7d0d8402aa93ef539de',
     x86_64: 'ac7002d89ff6d5537cd22b350d7b86c46424b7c8f918533b5d06239490727aae'
  })

  depends_on 'glibc' # R

  autotools_build_relative_dir '.'

  # The Makefile.in does not respect DESTDIR, so we override the buildsystem and append the explicit paths here.
  def self.build
    system "./configure --prefix=#{CREW_DEST_PREFIX} --mandir=#{CREW_DEST_MAN_PREFIX}"
    system 'make'
  end
end
