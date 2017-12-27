require 'package'

class Collectl < Package
  description 'Collectl is a light-weight performance monitoring tool capable of reporting interactively as well as logging to disk.'
  homepage 'http://collectl.sourceforge.net/'
  version '4.3.0'
  source_url 'https://downloads.sourceforge.net/project/collectl/collectl/collectl-4.3.0/collectl-4.3.0.src.tar.gz'
  source_sha256 'df7c7179963e05b8195519729e35eedd8ea8333a787cf9c5549b7b18228aa987'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/collectl-4.3.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/collectl-4.3.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/collectl-4.3.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/collectl-4.3.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '50a37619c46570ff71cd1154825cde479c3077f8b6e294ca132bf0122d379a79',
     armv7l: '50a37619c46570ff71cd1154825cde479c3077f8b6e294ca132bf0122d379a79',
       i686: '5f245a5d828ddf020fc07850cd0b941c1cab7645eec0a0ad66019933989fa924',
     x86_64: 'b6969809ec05e685dae42ef0345a2c3375e2d12ea2f4cfbcf1d37878d329484a',
  })

  depends_on 'perl'

  def self.build
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,' colmux"
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,' collectl"
    system "sed -i 's,/etc/\$ConfigFile,#{CREW_PREFIX}/etc/\$ConfigFile,' collectl"
    system "sed -i 's,DESTDIR=\${DESTDIR:=\"/\"},DESTDIR=#{CREW_DEST_PREFIX},' INSTALL"
    system "sed -i 's,\$DESTDIR/usr,\$DESTDIR,g' INSTALL"
    system "sed -i 's,/var/log,#{CREW_PREFIX}/logs,' INSTALL"
  end

  def self.install
    system "./INSTALL"
  end
end
