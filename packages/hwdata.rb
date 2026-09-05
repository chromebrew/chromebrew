# Adapted from Arch Linux hwdata PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/hwdata/trunk/PKGBUILD

require 'buildsystems/autotools'

class Hwdata < Autotools
  description 'hardware identification databases'
  homepage 'https://github.com/vcrhonek/hwdata'
  version '0.411'
  license 'GPL2'
  compatibility 'all'
  source_url 'https://github.com/vcrhonek/hwdata.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '74712c49ee1be9f4b90bc01c7507b48d032c973c36a0af4b275c22a023fd541a',
     armv7l: '74712c49ee1be9f4b90bc01c7507b48d032c973c36a0af4b275c22a023fd541a',
       i686: '85f99ae0cbec98cab8a4de9b8028f7e629d60b2628776444904efcf88d2f0143',
     x86_64: '1ad1d172d713abbfd711fa6e8da266a2ef051598bf614a8da7d1abb6567cdce7'
  })

  def self.patch
    system "sed -i 's,$(DESTDIR)$(datadir)/pkgconfig,$(DESTDIR)$(libdir)/pkgconfig,g' Makefile"
  end

  autotools_configure_options "--datadir=#{CREW_PREFIX}/share --disable-blacklist"
end
