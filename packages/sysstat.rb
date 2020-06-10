require "package"

class Sysstat < Package
  description 'The sysstat utilities are a collection of performance monitoring tools for Linux. These include sar, sadf, mpstat, iostat, tapestat, pidstat, cifsiostat and sa tools.'
  homepage 'http://sebastien.godard.pagesperso-orange.fr/'
  version '12.1.5'
  compatibility 'all'
  source_url 'http://pagesperso-orange.fr/sebastien.godard/sysstat-12.1.5.tar.xz'
  source_sha256 'a496936bb3f5093d780a50735f00e39b0b7f3a688eb89051f2ef5f86739522c5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sysstat-12.1.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sysstat-12.1.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sysstat-12.1.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sysstat-12.1.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '88f64d75bf8be7fe4cb8136ec188631a6e504c44951d8f2003f1998167be2df7',
     armv7l: '88f64d75bf8be7fe4cb8136ec188631a6e504c44951d8f2003f1998167be2df7',
       i686: 'c33bc10c60d55e2649e62a13b2f666e63035538103d8a81740de1ab0f170685e',
     x86_64: '5aac1bfb1bdf0a8d3dbeb010f179bbddeac24134768755d9dc3ccad01fb26f24',
  })

  def self.patch
    system "sed -i 's/GRP=root/GRP=$(whoami)/' configure"
    system "sed -i 's/\"root\"/\"$(whoami)\"/g' configure"
    system "sed -i 's/root/$(whoami)/g' configure.in"
    system "sed -i 's/root/$(whoami)/g' sysstat-#{self.version}.spec"
  end

  def self.build
    system "./configure \
            --docdir=#{CREW_PREFIX}/doc \
            --infodir=#{CREW_PREFIX}/info \
            --mandir=#{CREW_MAN_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

