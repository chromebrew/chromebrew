# Adapted from Arch Linux hwdata PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/hwdata/trunk/PKGBUILD

require 'buildsystems/autotools'

class Hwdata < Autotools
  description 'hardware identification databases'
  homepage 'https://github.com/vcrhonek/hwdata'
  version '0.412'
  license 'GPL2'
  compatibility 'all'
  source_url 'https://github.com/vcrhonek/hwdata.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '36871e8ba174f7497059e689e5112b032e2e2afd75a3cefd210f04a0a8016c35',
     armv7l: '36871e8ba174f7497059e689e5112b032e2e2afd75a3cefd210f04a0a8016c35',
       i686: 'ead7743f107110519fcf0a8b8812de2dd35fa3594e3b7935539cbd9bf6bb226f',
     x86_64: '1b99ba430185b5e34dc599d059b9bb9dbb7da49094e7cfcc936631296cf668f7'
  })

  def self.patch
    system "sed -i 's,$(DESTDIR)$(datadir)/pkgconfig,$(DESTDIR)$(libdir)/pkgconfig,g' Makefile"
  end

  autotools_configure_options "--datadir=#{CREW_PREFIX}/share --disable-blacklist"
end
