require 'package'

class Openlibm < Package
  description 'A high quality system independent, portable, open source libm implementation'
  homepage 'https://openlibm.org/'
  version '0.7.0'
  compatibility 'all'
  source_url 'https://github.com/JuliaMath/openlibm/archive/v0.7.0.tar.gz'
  source_sha256 '1699f773198018b55b12631db9c1801fe3ed191e618a1ee1be743f4570ae06a3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/openlibm-0.7.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/openlibm-0.7.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/openlibm-0.7.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/openlibm-0.7.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3c314f643ea1c940681fb6d504e397af0908235d9b2bce463351ffc47d064e80',
     armv7l: '3c314f643ea1c940681fb6d504e397af0908235d9b2bce463351ffc47d064e80',
       i686: '05fc93989659b621a63cb7846f0cec40b21afd72e82d5a495b6835ef2439bdea',
     x86_64: '874fa3a677169dc506eb3b24c52e2dafef433d4f34bacfb3e30696da8611bf64',
  })

  def self.patch
    system "sed -i 's,\$(DESTDIR)\$(libdir),#{CREW_DEST_LIB_PREFIX},g' Makefile"
    system "sed -i 's,\$(DESTDIR)\$(shlibdir),#{CREW_DEST_LIB_PREFIX},g' Makefile"
    system "sed -i 's,\$(DESTDIR)\$(includedir),#{CREW_DEST_PREFIX}/include,g' Makefile"
    system "sed -i 's,\$(DESTDIR)\$(pkgconfigdir),#{CREW_DEST_LIB_PREFIX}/pkgconfig,g' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
