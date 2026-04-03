# Adapted from Arch Linux hwdata PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/hwdata/trunk/PKGBUILD

require 'buildsystems/autotools'

class Hwdata < Autotools
  description 'hardware identification databases'
  homepage 'https://github.com/vcrhonek/hwdata'
  version '0.406'
  license 'GPL2'
  compatibility 'all'
  source_url 'https://github.com/vcrhonek/hwdata.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fac39d70e4f9509f177e53389b229cc1d1bc91fec17a142c3dc926c2f9edf1b2',
     armv7l: 'fac39d70e4f9509f177e53389b229cc1d1bc91fec17a142c3dc926c2f9edf1b2',
       i686: '631849df250feb7160d64f78022ab2f6c2e40da2a1c4d91b825f88a595e0e389',
     x86_64: '7c730b9fc8344edba4fc6f028b9fea06ed5d320a8483ff5ce20707fe31c6e301'
  })

  def self.patch
    system "sed -i 's,$(DESTDIR)$(datadir)/pkgconfig,$(DESTDIR)$(libdir)/pkgconfig,g' Makefile"
  end

  autotools_configure_options "--datadir=#{CREW_PREFIX}/share --disable-blacklist"
end
