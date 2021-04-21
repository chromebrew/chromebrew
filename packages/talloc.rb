# Adapted from Arch Linux talloc PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/talloc/trunk/PKGBUILD

require 'package'

class Talloc < Package
  description 'Hierarchical pool based memory allocator with destructors'
  homepage 'https://talloc.samba.org/'
  version '2.3.2'
  license 'LGPL'
  compatibility 'all'
  source_url "https://www.samba.org/ftp/talloc/talloc-#{version}.tar.gz"
  source_sha256 '27a03ef99e384d779124df755deb229cd1761f945eca6d200e8cfd9bf5297bd7'

  binary_url({
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/talloc-2.3.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7l/talloc-2.3.2-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/talloc-2.3.2-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/talloc-2.3.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '34e7e59fdd8ab619eb0a24aec3011093653399502038b7071395006dcf6e3b08',
     armv7l: '34e7e59fdd8ab619eb0a24aec3011093653399502038b7071395006dcf6e3b08',
       i686: 'f2b0b683234c60440ac6c53773aa8f38297ac8548c1a509773fa5bae836fbf47',
     x86_64: '0b22a9f1ce28259ba8d4fd046d00677c6b2590f2a0951a004d1f9d6173e592b6'
  })

  depends_on 'libbsd'
  depends_on 'libxcrypt'
  depends_on 'docbook_xsl' => :build

  def self.build
    system "env CFLAGS='-flto=auto' \
      CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure \
      #{CREW_OPTIONS.sub(/--program-suffix.*/, '')} \
      --sysconfdir=#{CREW_PREFIX}/etc/samba \
      --localstatedir=#{CREW_PREFIX}/var \
      --bundled-libraries=NONE \
      --builtin-libraries=replace \
      --enable-talloc-compat1"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
