require 'package'

class Libnl3 < Package
  description 'Library for applications dealing with netlink sockets.'
  homepage 'http://www.infradead.org/~tgr/libnl/'
  version '3.2.25'
  source_url 'http://www.infradead.org/~tgr/libnl/files/libnl-3.2.25.tar.gz'
  source_sha256 '8beb7590674957b931de6b7f81c530b85dc7c1ad8fbda015398bc1e8d1ce8ec5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libnl3-3.2.25-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libnl3-3.2.25-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libnl3-3.2.25-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libnl3-3.2.25-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1eeb2dc6b831749cfdb466fe7daafed0bd4621b799782237ad972a2f46bf6566',
     armv7l: '1eeb2dc6b831749cfdb466fe7daafed0bd4621b799782237ad972a2f46bf6566',
       i686: '466eadbbc822bc03308d5f7881510de0cc61e5bfa7647b9600898018168a6d44',
     x86_64: 'f29506472cccad26547d20afa519ed4823e2898a1822b43e7bc4a41f581d78c7',
  })

  depends_on "buildessential" => :build
  depends_on "glibc"

  def self.build
    system "./configure",
      "--prefix=/usr/local",
      "--sysconfdir=/usr/local/etc",
      "--sbindir=/usr/local/sbin",
      "--disable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
