require "package"

class Sysstat < Package
  description 'The sysstat utilities are a collection of performance monitoring tools for Linux. These include sar, sadf, mpstat, iostat, tapestat, pidstat, cifsiostat and sa tools.'
  homepage 'http://sebastien.godard.pagesperso-orange.fr/'
  version '11.5.6'
  source_url 'https://github.com/sysstat/sysstat/archive/v11.5.6.tar.gz'
  source_sha256 '2ba2c6bfe0870e3b10061ec19b2623283d4922bc6d824b1ba6534a27001d9fa8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sysstat-11.5.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sysstat-11.5.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sysstat-11.5.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sysstat-11.5.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6376f9189581bb9ffa7801774fb3a64a00f2d9d10ae1dc86cc85019567e65954',
     armv7l: '6376f9189581bb9ffa7801774fb3a64a00f2d9d10ae1dc86cc85019567e65954',
       i686: '247b803049bca37d2b0af7c0d4a1f0e5d73c04069d1bcfe1f650bef8398c9c18',
     x86_64: '2e52cf373e4eb15f317d4f1c1c5ef8ea865697102b061c98ce928bf1004c0ca5',
  })

  def self.build
    system "sed -i 's/GRP=root/GRP=$(whoami)/' configure"
    system "sed -i 's/\"root\"/\"$(whoami)\"/g' configure"
    system "sed -i 's/root/$(whoami)/g' configure.in"
    system "sed -i 's/root/$(whoami)/g' sysstat-11.5.6.spec"
    system "./configure \
            --docdir=/usr/local/doc \
            --infodir=/usr/local/info \
            --mandir=/usr/local/man"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

