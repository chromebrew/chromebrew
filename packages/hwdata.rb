# Adapted from Arch Linux hwdata PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/hwdata/trunk/PKGBUILD

require 'package'

class Hwdata < Package
  description 'hardware identification databases'
  homepage 'https://github.com/vcrhonek/hwdata'
  version '0.364'
  license 'GPL2'
  compatibility 'all'
  source_url 'https://github.com/vcrhonek/hwdata.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2c7eda3e087119c16dadfaaacb8114b8876b62f65af3a32da36450fb165b0a26',
     armv7l: '2c7eda3e087119c16dadfaaacb8114b8876b62f65af3a32da36450fb165b0a26',
       i686: 'e95f8441e9d608df1b1a1be0e82796a0d02fff3be81ca12fbf9709d6201a68fa',
     x86_64: 'c22a385eb2e767af12082d2334a49af8aafa5796b1174b869d5cfc2e0a8cec83'
  })

  def self.patch
    system "sed -i 's,$(DESTDIR)$(datadir)/pkgconfig,$(DESTDIR)$(libdir)/pkgconfig,g' Makefile"
  end

  def self.build
    system "./configure #{CREW_OPTIONS} \
      --datadir=#{CREW_PREFIX}/share \
      --disable-blacklist"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
