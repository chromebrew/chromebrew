# Adapted from Arch Linux hwdata PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/hwdata/trunk/PKGBUILD

require 'buildsystems/autotools'

class Hwdata < Autotools
  description 'hardware identification databases'
  homepage 'https://github.com/vcrhonek/hwdata'
  version '0.404'
  license 'GPL2'
  compatibility 'all'
  source_url 'https://github.com/vcrhonek/hwdata.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aecffcc211279b214a174a1dedecf800821e52c1327b36fdc8db3fa132558ce7',
     armv7l: 'aecffcc211279b214a174a1dedecf800821e52c1327b36fdc8db3fa132558ce7',
       i686: 'fe79d394ff2071130c91b76822d702dd191f1f40fcaa91807ea9e83d729f6f45',
     x86_64: '8c83f8ad04c42a7dabf43e23de651d3e3f2a24830fb8bec36780e24c112fbfc0'
  })

  def self.patch
    system "sed -i 's,$(DESTDIR)$(datadir)/pkgconfig,$(DESTDIR)$(libdir)/pkgconfig,g' Makefile"
  end

  autotools_configure_options "--datadir=#{CREW_PREFIX}/share --disable-blacklist"
end
