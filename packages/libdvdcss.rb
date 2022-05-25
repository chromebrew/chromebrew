# Adapted from Arch Linux libdvdcss PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/libdvdcss/trunk/PKGBUILD

require 'package'

class Libdvdcss < Package
  description 'Portable abstraction library for DVD decryption'
  homepage 'https://www.videolan.org/developers/libdvdcss.html'
  version '1.4.3'
  license 'GPL'
  compatibility 'all'
  source_url 'https://download.videolan.org/pub/libdvdcss/1.4.3/libdvdcss-1.4.3.tar.bz2'
  source_sha256 '233cc92f5dc01c5d3a96f5b3582be7d5cee5a35a52d3a08158745d3d86070079'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdvdcss/1.4.3_armv7l/libdvdcss-1.4.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdvdcss/1.4.3_armv7l/libdvdcss-1.4.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdvdcss/1.4.3_i686/libdvdcss-1.4.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdvdcss/1.4.3_x86_64/libdvdcss-1.4.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'dcda013e9e88b050507d38ace902d48d1330811e5e5c2218a9573158e0f4acf7',
     armv7l: 'dcda013e9e88b050507d38ace902d48d1330811e5e5c2218a9573158e0f4acf7',
       i686: '49c01747d762f5a9180a86a9f1df55412cf51888d45f7c70fcfaeb5ad5b3e111',
     x86_64: 'b7d83cd09f981bb3fadd013526f41854695961108e0b5b65e3d90e0bb44c0c0d'
  })

  depends_on 'glibc' # R

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
