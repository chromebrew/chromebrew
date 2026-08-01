# Adapted from Arch Linux hwdata PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/hwdata/trunk/PKGBUILD

require 'buildsystems/autotools'

class Hwdata < Autotools
  description 'hardware identification databases'
  homepage 'https://github.com/vcrhonek/hwdata'
  version '0.410'
  license 'GPL2'
  compatibility 'all'
  source_url 'https://github.com/vcrhonek/hwdata.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eadd425e88329e4d3fba2d3e72bbbebf215e495ad9905088d89f3b1cde070cbc',
     armv7l: 'eadd425e88329e4d3fba2d3e72bbbebf215e495ad9905088d89f3b1cde070cbc',
       i686: 'de5dd8cc29d810d21eabd9a1b368cca19b709622773a48bf90ca2cac07c888db',
     x86_64: 'b6eb25eb65836eee9fad1faa0027e6b1525b3659c385e137d143e82db9a112e0'
  })

  def self.patch
    system "sed -i 's,$(DESTDIR)$(datadir)/pkgconfig,$(DESTDIR)$(libdir)/pkgconfig,g' Makefile"
  end

  autotools_configure_options "--datadir=#{CREW_PREFIX}/share --disable-blacklist"
end
