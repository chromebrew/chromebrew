# Adapted from Arch Linux libimobiledevice PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libimobiledevice/trunk/PKGBUILD

require 'package'

class Libimobiledevice < Package
  description 'Library that talks the protocols to support iPhone and iPod Touch devices on Linux'
  homepage 'https://libimobiledevice.org/'
  version '1.3.0'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://github.com/libimobiledevice/libimobiledevice/archive/refs/tags/#{version}.tar.gz"
  source_sha256 'acbfb73eabee162e64c0d9de207d71c0a5f47c40cd5ad32a5097f734328ce10a'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '7a8a73892ac722226e44a17c810900213aa6c5e66c26ad23b8d30b379d5b7dae',
     armv7l: '7a8a73892ac722226e44a17c810900213aa6c5e66c26ad23b8d30b379d5b7dae',
       i686: '2580d6ecf627dce6a4dd6018ef3245e7352a95ac2fcd586627188379dc4489fa',
     x86_64: '11462fab4814036224fb3078792bad480627ead538309afcd93abfbb85121d65'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'libgcrypt'
  depends_on 'libplist'
  depends_on 'libusbmuxd'

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS} --disable-openssl"
    system 'make'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} make install"
  end
end
