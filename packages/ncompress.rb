# Adapted from Arch Linux ncompress PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/ncompress/trunk/PKGBUILD

require 'package'

class Ncompress < Package
  description 'a fast, simple LZW file compressor'
  homepage 'https://github.com/vapier/ncompress'
  version '5.0'
  license 'PublicDomain'
  compatibility 'all'
  source_url 'https://github.com/vapier/ncompress/archive/v5.0.tar.gz'
  source_sha256 '96ec931d06ab827fccad377839bfb91955274568392ddecf809e443443aead46'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a3e3069054eccfc3011cc705f49123bb08fdb5de39e2848749a584be0a406d35',
     armv7l: 'a3e3069054eccfc3011cc705f49123bb08fdb5de39e2848749a584be0a406d35',
       i686: 'a0e95bd06aa844286d5b4a92ef5d65073d152a82ab63384a3dcd3b3c4f1d0ad7',
     x86_64: 'a84ba675a89c4184c1e2495b0a016f964ff75f2b0f2a977552cf7fd94be136b4'
  })

  depends_on 'glibc'

  def self.build
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} PREFIX=#{CREW_PREFIX} install_core"
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/uncompress", "#{CREW_DEST_PREFIX}/bin/uncompress.real"
  end
end
