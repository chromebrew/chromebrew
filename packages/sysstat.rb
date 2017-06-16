require "package"

class Sysstat < Package
  description 'The sysstat utilities are a collection of performance monitoring tools for Linux. These include sar, sadf, mpstat, iostat, tapestat, pidstat, cifsiostat and sa tools.'
  homepage 'http://sebastien.godard.pagesperso-orange.fr/'
  version '11.5.6'
  source_url 'https://github.com/sysstat/sysstat/archive/v11.5.6.tar.gz'
  source_sha1 'a8913a7a8418590bc6ea77a7bbe737577ef96e33'

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

