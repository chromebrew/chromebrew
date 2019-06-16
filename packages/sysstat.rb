require "package"

class Sysstat < Package
  description 'The sysstat utilities are a collection of performance monitoring tools for Linux. These include sar, sadf, mpstat, iostat, tapestat, pidstat, cifsiostat and sa tools.'
  homepage 'http://sebastien.godard.pagesperso-orange.fr/'
  version '12.1.5'
  source_url 'http://pagesperso-orange.fr/sebastien.godard/sysstat-12.1.5.tar.xz'
  source_sha256 'a496936bb3f5093d780a50735f00e39b0b7f3a688eb89051f2ef5f86739522c5'

  def self.build
    system "sed -i 's/GRP=root/GRP=$(whoami)/' configure"
    system "sed -i 's/\"root\"/\"$(whoami)\"/g' configure"
    system "sed -i 's/root/$(whoami)/g' configure.in"
    system "sed -i 's/root/$(whoami)/g' sysstat-#{self.version}.spec"
    system "./configure \
            --docdir=#{CREW_PREFIX}/doc \
            --infodir=#{CREW_PREFIX}/info \
            --mandir=#{CREW_PREFIX}/man"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

