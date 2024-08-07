require 'buildsystems/autotools'

class Dehtml < Autotools
  description 'Dehtml removes HTML constructs from documents for indexing, spell checking and so on.'
  homepage 'http://www.moria.de/~michael/dehtml/'
  version '1.8-1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'http://www.moria.de/~michael/dehtml/dehtml-1.8.tar.gz'
  source_sha256 'a00e86643b0aa73861e9d8d619a80370f0f99519d34ce12459fab77f5f6b5bde'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bf71a6d20c294963a7dd9ac875d0d4b03df747664de408cf72c958e26d706195',
     armv7l: 'bf71a6d20c294963a7dd9ac875d0d4b03df747664de408cf72c958e26d706195',
       i686: '2484ea4c57eed480d14ea7f33b2ed75b813adcf92bbaaa43b45acff954f4832e',
     x86_64: '02b2bb63225eee9a2eb464fd3f663f9d692e4575d0b83e203a6f54e61446d04d'
  })

  depends_on 'glibc' # R

  def self.build
    system "./configure --prefix=#{CREW_DEST_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make install'
  end
end
