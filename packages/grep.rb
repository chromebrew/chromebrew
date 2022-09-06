# Adapted from Arch Linux grep PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/grep/trunk/PKGBUILD

require 'package'

class Grep < Package
  description 'A string search utility'
  homepage 'https://www.gnu.org/software/grep/'
  version '3.8'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/grep/grep-3.8.tar.xz'
  source_sha256 '498d7cc1b4fb081904d87343febb73475cf771e424fb7e6141aff66013abc382'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/grep/3.8_armv7l/grep-3.8-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/grep/3.8_armv7l/grep-3.8-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/grep/3.8_i686/grep-3.8-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/grep/3.8_x86_64/grep-3.8-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '370bc4fa22b15c51baa50e1f4b477bbd1e92f5b43e49a72393efa5c4af842330',
     armv7l: '370bc4fa22b15c51baa50e1f4b477bbd1e92f5b43e49a72393efa5c4af842330',
       i686: 'ce9a41e16cf4a3d056f82e0281bfe50288dac53717d51287355e5b3bbe9afdff',
     x86_64: '3d525207a010f50d6c929028138d876d43e11dc6d21172b739fbe012f4e0c942'
  })

  depends_on 'pcre'
  # NOTE: built on i686 by removing the c11threads derived threads.h
  # installed by the chromebrew glibc package on this architecture.

  def self.build
    system "CPPFLAGS=-DHAVE_DYNAMIC_LIBPCRE \
      ./configure #{CREW_OPTIONS} \
      --without-included-regex"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
