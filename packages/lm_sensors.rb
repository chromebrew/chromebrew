require 'package'

class Lm_sensors < Package
  description 'Collection of user space tools for general SMBus access and hardware monitoring'
  homepage 'https://hwmon.wiki.kernel.org/lm_sensors'
  version '3.6.0'
  compatibility 'all'
  source_url 'https://github.com/lm-sensors/lm-sensors/archive/V3-6-0.tar.gz'
  source_sha256 '0591f9fa0339f0d15e75326d0365871c2d4e2ed8aa1ff759b3a55d3734b7d197'



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
