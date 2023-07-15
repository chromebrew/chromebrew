# Adapted from Arch Linux nftables PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/nftables/trunk/PKGBUILD

require 'package'

class Nftables < Package
  description 'Netfilter tables userspace tools'
  homepage 'https://netfilter.org/projects/nftables/'
  version '1.0.8'
  license 'GPL2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://netfilter.org/projects/nftables/files/nftables-1.0.8.tar.xz'
  source_sha256 '9373740de41a82dbc98818e0a46a073faeb8a8d0689fa4fa1a74399c32bf3d50'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nftables/1.0.8_armv7l/nftables-1.0.8-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nftables/1.0.8_armv7l/nftables-1.0.8-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nftables/1.0.8_x86_64/nftables-1.0.8-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b1151ae07c75b41f9263acd4c0197c7ec0dd6bf3666d4f214aef90cdd1af23e1',
     armv7l: 'b1151ae07c75b41f9263acd4c0197c7ec0dd6bf3666d4f214aef90cdd1af23e1',
     x86_64: '87087b6ac01cd72c6293701453b8bae99795bbcf68cfd874de91936363048e40'
  })

  depends_on 'asciidoc' => :build
  depends_on 'glibc' # R
  depends_on 'jansson' # R
  depends_on 'libmnl' # R
  depends_on 'libnftnl' # R
  depends_on 'readline' # R

  def self.build
    system 'autoreconf -fiv'
    system "./configure \
           --prefix=#{CREW_PREFIX} \
           --libdir=#{CREW_LIB_PREFIX} \
           --sysconfdir=#{CREW_PREFIX}/etc \
           --with-json \
           --with-cli=readline \
           --with-mini-gmp \
           --disable-debug"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
