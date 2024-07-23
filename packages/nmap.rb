# Adapted from Arch Linux nmap PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/nmap/trunk/PKGBUILD

require 'package'

class Nmap < Package
  description 'Utility for network discovery and security auditing'
  homepage 'https://nmap.org/'
  version '7.94'
  license 'GPL2'
  compatibility 'all'
  source_url 'https://nmap.org/dist/nmap-7.94.tar.bz2'
  source_sha256 'd71be189eec43d7e099bac8571509d316c4577ca79491832ac3e1217bc8f92cc'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4ce57407189a3fb6becebd5c637a8cfbe774e19be1cea644964d71d37f89f451',
     armv7l: '4ce57407189a3fb6becebd5c637a8cfbe774e19be1cea644964d71d37f89f451',
       i686: '7e7251d159c50fe2e44ca92c65a36ab008d345e42689f8a108b75e007d58ccfd',
     x86_64: 'e17ede47738f031cae4f8cc673550b293ae72d2315ecb09896fc60cbee9bd0a2'
  })

  depends_on 'libpcap'
  depends_on 'libssh2'

  def self.patch
    # ensure we build "devendored deps"
    @deps = %w[libpcap libpcre macosx mwin32 libssh2 libz]
    @deps.each do |dep|
      FileUtils.rm_rf dep
    end
    system 'filefix'
  end

  def self.build
    system "./configure #{CREW_OPTIONS} \
      --with-libpcap=#{CREW_PREFIX} \
      --with-libpcre=#{CREW_PREFIX} \
      --with-zlib=#{CREW_PREFIX} \
      --with-libssh2=#{CREW_PREFIX} \
      --with-liblua=included \
      --without-ndiff"
    system 'make'
    File.write 'zenmap.sh', <<~ZENMAP_EOF
      #!/bin/sh
      xhost si:localuser:root
      sudo -E LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} zenmap.elf "$@"
    ZENMAP_EOF
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/zenmap", "#{CREW_DEST_PREFIX}/bin/zenmap.elf"
    FileUtils.install 'zenmap.sh', "#{CREW_DEST_PREFIX}/bin/zenmap", mode: 0o755
  end
end
