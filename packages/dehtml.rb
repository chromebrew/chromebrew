require 'buildsystems/autotools'

class Dehtml < Autotools
  description 'Dehtml removes HTML constructs from documents for indexing, spell checking and so on.'
  homepage 'http://www.moria.de/~michael/dehtml/'
  version '2.0'
  license 'GPL-2+'
  compatibility 'all'
  source_url "http://www.moria.de/~michael/dehtml/dehtml-#{version}.tar.gz"
  source_sha256 '838d2a3c892eab8f26a29c94732b8eff2ce5594014ea1da09e3a532d5149b2db'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '649cb05f43386af89a6717b45e40cca2d83bfbdd804688dd7d9ae82519de3139',
     armv7l: '649cb05f43386af89a6717b45e40cca2d83bfbdd804688dd7d9ae82519de3139',
       i686: '3dd3356aca416e5cbcbb4d351bc045ab3e8bf7180103aa1667f2b148a3c9c0de',
     x86_64: '67800096fda44e8685c9a74d785c35b070be22b5ca1de16f7d1cbda33e9b8a59'
  })

  depends_on 'glibc' # R

  autotools_build_relative_dir '.'

  def self.patch
    # Fix config.status: error: cannot find input file: `test/run.in'.
    system "sed -i 's, test/run,,' configure"
    # Fix chmod: missing operand after '755'.
    system "sed -i 's,chmod 755,,' configure"
  end

  # The Makefile.in does not respect DESTDIR, so we override the buildsystem and append the explicit paths here.
  def self.build
    system "./configure --prefix=#{CREW_DEST_PREFIX} --mandir=#{CREW_DEST_MAN_PREFIX}"
    system 'make'
  end
end
