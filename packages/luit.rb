# Adapted from Arch Linux luit PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/luit/trunk/PKGBUILD

require 'package'

class Luit < Package
  description 'Filter that can be run between an arbitrary application and a UTF-8 terminal emulator'
  homepage 'https://invisible-island.net/luit/luit.html'
  version '2_0_20230201'
  license 'custom'
  compatibility 'all'
  source_url 'https://github.com/ThomasDickey/luit-snapshots.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '04d87e98277c2b522ea8f088b11a79a46abb15700dc44db9cd85e17e4c37d111',
     armv7l: '04d87e98277c2b522ea8f088b11a79a46abb15700dc44db9cd85e17e4c37d111',
       i686: '76a095380f067f4e1e50a0f52fa9c7fca2764d4fef9f44872d51bb6fa3102d12',
     x86_64: '038cf6925d94fdb7ab7f9982c998eadeedd254e6e0a13c5e7db4b4ef6dc0a094'
  })

  depends_on 'glibc' # R
  depends_on 'libfontenc' # R
  depends_on 'libx11' => ':build'

  def self.build
    system "./configure #{CREW_OPTIONS} --enable-fontenc"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
