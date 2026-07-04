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
    aarch64: 'a6dcbb3103bf466ee66c0f76bb78201f38378b6c69c31d5d1d9831a33f8f2483',
     armv7l: 'a6dcbb3103bf466ee66c0f76bb78201f38378b6c69c31d5d1d9831a33f8f2483',
       i686: '7cd03f67fcccfece44d409c6a40bcacb4412f41d31b89f963b10149f37cb2acd',
     x86_64: '01320b65d655095f49cf65df01adc28f9fd5353a10ea6f80db794c18beb3c45b'
  })

  def self.patch
    system "sed -i 's,$(DESTDIR)$(datadir)/pkgconfig,$(DESTDIR)$(libdir)/pkgconfig,g' Makefile"
  end

  autotools_configure_options "--datadir=#{CREW_PREFIX}/share --disable-blacklist"
end
