# Adapted from Arch Linux bridge-utils PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/bridge-utils/trunk/PKGBUILD

require 'package'

class Bridge_utils < Package
  description 'Utilities for configuring the Linux ethernet bridge'
  homepage 'https://wiki.linuxfoundation.org/networking/bridge'
  version '1.7.1'
  license 'GPL'
  compatibility 'all'
  source_url 'https://mirrors.edge.kernel.org/pub/linux/utils/net/bridge-utils/bridge-utils-1.7.1.tar.xz'
  source_sha256 'a61d8be4f1a1405c60c8ef38d544f0c18c05b33b9b07e5b4b31033536165e60e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f1984061ce11bccfdd46b10ccf02aabc66b1e179a257892a6478d85fc76f6466',
     armv7l: 'f1984061ce11bccfdd46b10ccf02aabc66b1e179a257892a6478d85fc76f6466',
       i686: 'd358c174c2abfd5f2fd3528d90171a5d9f1991a347c4839128ca9797dd5e5a58',
     x86_64: '6abba3cb24ba0e3faa044e91d57559d7df7f752c5ccf45a5e1e29c51271e10bd'
  })

  depends_on 'glibc' # R
  depends_on 'gcc_lib' # R

  def self.build
    system 'autoreconf -fvi'
    system "./configure \
      #{CREW_OPTIONS} \
      --sbindir=#{CREW_PREFIX}/bin \
      --sysconfdir=#{CREW_PREFIX}/etc"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
