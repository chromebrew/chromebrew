# Adapted from Arch Linux hwdata PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/hwdata/trunk/PKGBUILD

require 'buildsystems/autotools'

class Hwdata < Autotools
  description 'hardware identification databases'
  homepage 'https://github.com/vcrhonek/hwdata'
  version '0.403'
  license 'GPL2'
  compatibility 'all'
  source_url 'https://github.com/vcrhonek/hwdata.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e5b33b1b7e203987171f5e814ab887b37c8a3203356e35c7a1553bb89ae3011d',
     armv7l: 'e5b33b1b7e203987171f5e814ab887b37c8a3203356e35c7a1553bb89ae3011d',
       i686: '56bf21cab8c734af090794eabc9c0cc408a6e756dc8cb29c2ab7dcce9de2a2e6',
     x86_64: '835f9d294c19cb4e6e5c83fdf0831df1141a8d5780380de01bceda7d995c4ce7'
  })

  def self.patch
    system "sed -i 's,$(DESTDIR)$(datadir)/pkgconfig,$(DESTDIR)$(libdir)/pkgconfig,g' Makefile"
  end

  autotools_configure_options "--datadir=#{CREW_PREFIX}/share --disable-blacklist"
end
