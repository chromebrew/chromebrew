# Adapted from Arch Linux hwdata PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/hwdata/trunk/PKGBUILD

require 'buildsystems/autotools'

class Hwdata < Autotools
  description 'hardware identification databases'
  homepage 'https://github.com/vcrhonek/hwdata'
  version '0.413'
  license 'GPL2'
  compatibility 'all'
  source_url 'https://github.com/vcrhonek/hwdata.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '21cf6c0617079bbb2f7be4e36ac6eeb0aafe9025a209802a7595663c5c1aaae9',
     armv7l: '21cf6c0617079bbb2f7be4e36ac6eeb0aafe9025a209802a7595663c5c1aaae9',
       i686: '070d60797ed707540c67b392adefd626e7a4e164fbf1768460cf5afd311b09f7',
     x86_64: '65ee51931b34e8f33eb6fa4cc070ef4b5bab3a61ff2a995c0aabf0a0c2047905'
  })

  def self.patch
    system "sed -i 's,$(DESTDIR)$(datadir)/pkgconfig,$(DESTDIR)$(libdir)/pkgconfig,g' Makefile"
  end

  autotools_configure_options "--datadir=#{CREW_PREFIX}/share --disable-blacklist"
end
