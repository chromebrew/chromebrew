# Adapted from Arch Linux protobuf-c PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/protobuf-c/trunk/PKGBUILD

require 'package'

class Protobuf_c < Package
  description 'Protocol Buffers implementation in C'
  homepage 'https://github.com/protobuf-c/protobuf-c'
  version '1.4.1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/protobuf-c/protobuf-c/releases/download/v1.4.1/protobuf-c-1.4.1.tar.gz'
  source_sha256 '4cc4facd508172f3e0a4d3a8736225d472418aee35b4ad053384b137b220339f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/protobuf_c/1.4.1_armv7l/protobuf_c-1.4.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/protobuf_c/1.4.1_armv7l/protobuf_c-1.4.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/protobuf_c/1.4.1_i686/protobuf_c-1.4.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/protobuf_c/1.4.1_x86_64/protobuf_c-1.4.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f7b0d4df39c76edd82f3b150edf5d660a9613440755bcb35a0c267d97c34d650',
     armv7l: 'f7b0d4df39c76edd82f3b150edf5d660a9613440755bcb35a0c267d97c34d650',
       i686: 'c2b26a13859ebbfcfff7436e40ca45b9cd051255e090ae04852b91db190cbbb4',
     x86_64: '1aaf27b5d3f5bc90042f1beeb3f5b08240695bcf7fae46b80f5a72b81f4aeb86'
  })

  depends_on 'protobuf'
  depends_on 'glibc' # R
  depends_on 'gcc_lib' # R

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
