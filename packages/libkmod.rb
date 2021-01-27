require 'package'

class Libkmod < Package
  description 'Linux kernel module handling library'
  homepage 'https://kernel.org'
  @_ver = '28'
  version @_ver
  compatibility 'all'
  source_url "https://mirrors.edge.kernel.org/pub/linux/utils/kernel/kmod/kmod-#{@_ver}.tar.xz"
  source_sha256 '3969fc0f13daa98084256337081c442f8749310089e48aa695c9b4dfe1b3a26c'

  binary_url ({
     aarch64: 'file:///usr/local/tmp/packages/libkmod-28-chromeos-armv7l.tar.xz',
      armv7l: 'file:///usr/local/tmp/packages/libkmod-28-chromeos-armv7l.tar.xz',
        i686: 'file:///usr/local/tmp/packages/libkmod-28-chromeos-i686.tar.xz',
      x86_64: 'file:///usr/local/tmp/packages/libkmod-28-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '57c5726cd378bf3e1458cdfebead52b9279557af8229550d5f91f0a3e04d4f10',
      armv7l: '57c5726cd378bf3e1458cdfebead52b9279557af8229550d5f91f0a3e04d4f10',
        i686: '95c805d62289d8751682d4bb1c8046deeae68958e0f06f6863e30eb74e941864',
      x86_64: '258578c242a793bfda78e9dc98a9e029a8788e9971a809d0c6e42c2abe10b317',
  })

  depends_on 'xzutils'

  def self.build
    system "./configure #{CREW_OPTIONS} --enable-python --disable-maintainer-mode --with-openssl --with-zlib --with-xz"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/sbin"
    FileUtils.ln_s "#{CREW_PREFIX}/bin/kmod", "#{CREW_DEST_PREFIX}/bin/lsmod"
    FileUtils.ln_s "#{CREW_PREFIX}/bin/kmod", "#{CREW_DEST_PREFIX}/sbin/depmod"
    FileUtils.ln_s "#{CREW_PREFIX}/bin/kmod", "#{CREW_DEST_PREFIX}/sbin/insmod"
    FileUtils.ln_s "#{CREW_PREFIX}/bin/kmod", "#{CREW_DEST_PREFIX}/sbin/modinfo"
    FileUtils.ln_s "#{CREW_PREFIX}/bin/kmod", "#{CREW_DEST_PREFIX}/sbin/modprobe"
    FileUtils.ln_s "#{CREW_PREFIX}/bin/kmod", "#{CREW_DEST_PREFIX}/sbin/rmmod"
  end
end
