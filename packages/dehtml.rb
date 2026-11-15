require 'buildsystems/autotools'

class Dehtml < Autotools
  description 'Dehtml removes HTML constructs from documents for indexing, spell checking and so on.'
  homepage 'http://www.moria.de/~michael/dehtml/'
  version '2.1'
  license 'GPL-2+'
  compatibility 'all'
  source_url "http://www.moria.de/~michael/dehtml/dehtml-#{version}.tar.gz"
  source_sha256 '3dd66197f2438a17ed16abc572207a25eb1d74776a228e1f294c42d56639f9c3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '384ee28a3f36a84c25637f5679b153228ac63da210af39d54434491e694451cf',
     armv7l: '384ee28a3f36a84c25637f5679b153228ac63da210af39d54434491e694451cf',
       i686: 'c2beceecd2db8db317e942da8109570a2441b70ed2e9dfe73cb702dfb5756555',
     x86_64: '5734580522004fd5b727a3cfc0500d78a2c6a0e9eeadab6b2b117dcfbe0dd26b'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  autotools_build_relative_dir '.'

  # The Makefile.in does not respect DESTDIR, so we override the buildsystem and append the explicit paths here.
  def self.build
    system "./configure --prefix=#{CREW_DEST_PREFIX} --mandir=#{CREW_DEST_MAN_PREFIX}"
    system 'make'
  end
end
