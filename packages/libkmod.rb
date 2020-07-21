require 'package'

class Libkmod < Package
  description 'Linux kernel module handling library'
  homepage 'https://kernel.org'
  version '27'
  compatibility 'all'
  source_url 'https://mirrors.edge.kernel.org/pub/linux/utils/kernel/kmod/kmod-27.tar.xz'
  source_sha256 'c1d3fbf16ca24b95f334c1de1b46f17bbe5a10b0e81e72668bdc922ebffbbc0c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libkmod-27-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libkmod-27-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libkmod-27-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libkmod-27-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '852023187ef8d31a0854ba5dfe0383eb06f492411a2c2e36cddb7fdf5377acde',
     armv7l: '852023187ef8d31a0854ba5dfe0383eb06f492411a2c2e36cddb7fdf5377acde',
       i686: 'dd511bb365310f101a649f043530524a184ea39cdd42eea9dbf0ff1182e69b22',
     x86_64: 'd4a0b2379cb57cd28f0410eb2abe3e151fb7dcbdb645ddfb90119e553632670d',
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
