# Adapted from Arch Linux hwdata PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/hwdata/trunk/PKGBUILD

require 'buildsystems/autotools'

class Hwdata < Autotools
  description 'hardware identification databases'
  homepage 'https://github.com/vcrhonek/hwdata'
  version '0.407'
  license 'GPL2'
  compatibility 'all'
  source_url 'https://github.com/vcrhonek/hwdata.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f3e11d51310bf02d787505168bd1b28c569f602e744fe483c8ef7ab776292b9c',
     armv7l: 'f3e11d51310bf02d787505168bd1b28c569f602e744fe483c8ef7ab776292b9c',
       i686: '0c5d8c589346e7f477577b2271dded11bd2bd070caaaddcb739a467edb5d7731',
     x86_64: 'e43553ce5639a884ab595226e4dc58a545f5c007eef0d082a3020584b656df66'
  })

  def self.patch
    system "sed -i 's,$(DESTDIR)$(datadir)/pkgconfig,$(DESTDIR)$(libdir)/pkgconfig,g' Makefile"
  end

  autotools_configure_options "--datadir=#{CREW_PREFIX}/share --disable-blacklist"
end
