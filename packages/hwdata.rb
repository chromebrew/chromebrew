# Adapted from Arch Linux hwdata PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/hwdata/trunk/PKGBUILD

require 'buildsystems/autotools'

class Hwdata < Autotools
  description 'hardware identification databases'
  homepage 'https://github.com/vcrhonek/hwdata'
  version '0.405'
  license 'GPL2'
  compatibility 'all'
  source_url 'https://github.com/vcrhonek/hwdata.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '83c9fb6adc0f49120277db99e9d8adae72bf9edcc2165a6f4c4ae22a4a72113f',
     armv7l: '83c9fb6adc0f49120277db99e9d8adae72bf9edcc2165a6f4c4ae22a4a72113f',
       i686: '313b585608515326bdcde0e8142bb7d653696dfdd23556cdd1ddbe3055f725d0',
     x86_64: 'c54e9a292c9676a50c84f290b195590296545e213d0a1f6f46322982123f2eb9'
  })

  def self.patch
    system "sed -i 's,$(DESTDIR)$(datadir)/pkgconfig,$(DESTDIR)$(libdir)/pkgconfig,g' Makefile"
  end

  autotools_configure_options "--datadir=#{CREW_PREFIX}/share --disable-blacklist"
end
