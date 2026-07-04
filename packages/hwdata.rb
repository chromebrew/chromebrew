# Adapted from Arch Linux hwdata PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/hwdata/trunk/PKGBUILD

require 'buildsystems/autotools'

class Hwdata < Autotools
  description 'hardware identification databases'
  homepage 'https://github.com/vcrhonek/hwdata'
  version '0.409'
  license 'GPL2'
  compatibility 'all'
  source_url 'https://github.com/vcrhonek/hwdata.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bdb98a969203301b8db63df2dc5fc1d4cd50932e9d79b98fe8f9a1b5a229102f',
     armv7l: 'bdb98a969203301b8db63df2dc5fc1d4cd50932e9d79b98fe8f9a1b5a229102f',
       i686: 'c849ec3d1058e9d615b35d61fec0b21e7785016c307fd4121f3de27b49419582',
     x86_64: '31d955a2e78d9260605310dc038d9f0a1d4adc4901c8809ed254dd9ab12ce8b6'
  })

  def self.patch
    system "sed -i 's,$(DESTDIR)$(datadir)/pkgconfig,$(DESTDIR)$(libdir)/pkgconfig,g' Makefile"
  end

  autotools_configure_options "--datadir=#{CREW_PREFIX}/share --disable-blacklist"
end
