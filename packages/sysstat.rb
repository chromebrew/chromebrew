require "package"

class Sysstat < Package
  description 'The sysstat utilities are a collection of performance monitoring tools for Linux. These include sar, sadf, mpstat, iostat, tapestat, pidstat, cifsiostat and sa tools.'
  homepage 'http://sebastien.godard.pagesperso-orange.fr/'
  version '11.5.6'
  source_url 'https://github.com/sysstat/sysstat/archive/v11.5.6.tar.gz'
  source_sha256 '2ba2c6bfe0870e3b10061ec19b2623283d4922bc6d824b1ba6534a27001d9fa8'

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

