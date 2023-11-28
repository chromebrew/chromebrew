# Adapted from Arch Linux tllist PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=tllist

require 'package'

class Tllist < Package
  description 'A typed linked list C header file only library'
  homepage 'https://codeberg.org/dnkl/tllist'
  version '1.0.5'
  license 'MIT'
  compatibility 'all'
  source_url 'https://codeberg.org/dnkl/tllist.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tllist/1.0.5_armv7l/tllist-1.0.5-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tllist/1.0.5_armv7l/tllist-1.0.5-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tllist/1.0.5_i686/tllist-1.0.5-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tllist/1.0.5_x86_64/tllist-1.0.5-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '6eefb42195190f840d23f07dbfb76963abd124babf09d5253b1e08ac9bdba5de',
     armv7l: '6eefb42195190f840d23f07dbfb76963abd124babf09d5253b1e08ac9bdba5de',
       i686: '36cb299932fcebce6c373980fc427196334fbc8b6cb5a69b7880945f35ea1475',
     x86_64: '7b46ee399514bd499c3a82f8c10916ed76f2c9c88a49cf75e348f683952dfd96'
  })

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      builddir"
    system 'meson configure --no-pager builddir'
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
