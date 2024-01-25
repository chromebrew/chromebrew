require 'package'

class Chrpath < Package
  description 'Change or delete the rpath or runpath in ELF files'
  homepage 'https://directory.fsf.org/project/chrpath/'
  version '0.16'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://httpredir.debian.org/debian/pool/main/c/chrpath/chrpath_0.16.orig.tar.gz'
  source_sha256 'bb0d4c54bac2990e1bdf8132f2c9477ae752859d523e141e72b3b11a12c26e7b'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '90a116020875ffc085d1da9352d6fadb08cedf5e50e73b296380e00d061d82f1',
     armv7l: '90a116020875ffc085d1da9352d6fadb08cedf5e50e73b296380e00d061d82f1',
       i686: 'af52c7da43448bb4ea99e96dd28534627cfc1665273fcfa5ecbba6093956f91c',
     x86_64: '620cedb1453b3b30fa23d036708956dbadbf8dda7f1afd470c8bcfe2bba56f07'
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
