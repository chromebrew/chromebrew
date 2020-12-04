require 'package'

class Lm_sensors < Package
  description 'Collection of user space tools for general SMBus access and hardware monitoring'
  homepage 'https://hwmon.wiki.kernel.org/lm_sensors'
  version '3.6.0'
  compatibility 'all'
  source_url 'https://github.com/lm-sensors/lm-sensors/archive/V3-6-0.tar.gz'
  source_sha256 '0591f9fa0339f0d15e75326d0365871c2d4e2ed8aa1ff759b3a55d3734b7d197'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/lm_sensors-3.6.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/lm_sensors-3.6.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/lm_sensors-3.6.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/lm_sensors-3.6.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f823f0cdfd1e20b45169972dc3708ca4f92ac5eaf2a7910436c9a48e2a9764fc',
     armv7l: 'f823f0cdfd1e20b45169972dc3708ca4f92ac5eaf2a7910436c9a48e2a9764fc',
       i686: '02dc0f9719ad8a8dad023187f39296cfe863d28f7e40247ae6dfda71fc598582',
     x86_64: '2561335f0dbe8c442e509bd6ca29751ea3c05c9a6111766ffc2380cb60dff6d1',
  })

  def self.build
    system "sed -i 's/-Llib -lsensors/-Llib -lsensors -liconv/g' prog/sensors/Module.mk"
    system "sed -i \"/LIBDIR :=/c LIBDIR := #{CREW_LIB_PREFIX}\" Makefile"
    system "sed -i \"/ETCDIR :=/c ETCDIR := #{CREW_PREFIX}\/etc\" Makefile"
    system "make PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    system "make PREFIX=#{CREW_PREFIX} DESTDIR=#{CREW_DEST_DIR} install"
  end
end
