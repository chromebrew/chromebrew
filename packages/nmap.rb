# Adapted from Arch Linux nmap PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/nmap/trunk/PKGBUILD

require 'package'

class Nmap < Package
  description 'Utility for network discovery and security auditing'
  homepage 'https://nmap.org/'
  version '7.91'
  license 'GPL2'
  compatibility 'all'
  source_url 'https://nmap.org/dist/nmap-7.91.tar.bz2'
  source_sha256 '18cc4b5070511c51eb243cdd2b0b30ff9b2c4dc4544c6312f75ce3a67a593300'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nmap/7.91_armv7l/nmap-7.91-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nmap/7.91_armv7l/nmap-7.91-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nmap/7.91_i686/nmap-7.91-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nmap/7.91_x86_64/nmap-7.91-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'b4a00869eb4406a56b541d6f0acc93ac9ca94aa9e6aa89b9f8dea098abc23447',
     armv7l: 'b4a00869eb4406a56b541d6f0acc93ac9ca94aa9e6aa89b9f8dea098abc23447',
       i686: '1d02de32a0e266752fefab260e59d7dbfea5fcd3ac57f2dcc87116fe3e1aef00',
     x86_64: '047f51c3a169ea6d76b45d18fa86c5f6eada542ceca4c02a9ff6e5fafcfb5201'
  })

  depends_on 'libpcap'
  depends_on 'libssh2'

  def self.build
    # ensure we build devendored deps"
    @deps = %w[libpcap libpcre macosx mwin32 libssh2 libz]
    @deps.each do |dep|
      FileUtils.rm_rf dep
    end
    system 'autoreconf -fiv'
    system 'filefix'
    system "env #{CREW_ENV_OPTIONS} \
    ./configure \
    #{CREW_OPTIONS} \
    --with-libpcap=#{CREW_PREFIX} \
    --with-libpcre=#{CREW_PREFIX} \
    --with-zlib=#{CREW_PREFIX} \
    --with-libssh2=#{CREW_PREFIX} \
    --with-liblua=included \
    --without-ndiff"
    system 'make'
    @zenmap_ = <<~'ZENMAP_EOF'
      #!/bin/sh
      xhost si:localuser:root
      sudo -E LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} zenmap.elf
    ZENMAP_EOF
    File.write('zenmap_', @zenmap_)
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/zenmap", "#{CREW_DEST_PREFIX}/bin/zenmap.elf"
    FileUtils.install 'zenmap_', "#{CREW_DEST_PREFIX}/bin/zenmap", mode: 0o755
  end
end
