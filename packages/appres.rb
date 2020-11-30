require 'package'

class Appres < Package
  description 'The appres program prints the resources seen by an application (or subhierarchy of an application) with the specified class and instance names.'
  homepage 'https://www.x.org'
  version '1.0.5'
  compatibility 'all'
  source_url 'https://x.org/archive/individual/app/appres-1.0.5.tar.bz2'
  source_sha256 'ffad893712c81943b919e3cbfe46fc65259cc0d9eb96d5e658670e3fbb265928'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/appres-1.0.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/appres-1.0.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/appres-1.0.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/appres-1.0.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e470f6c5a1c9d2ef2f89efe68b1243952d6697f8cd265b1baca52353933b9908',
     armv7l: 'e470f6c5a1c9d2ef2f89efe68b1243952d6697f8cd265b1baca52353933b9908',
       i686: 'ecfbf924a5003f2de92a65c559f0422547fe336d704d2e1d99b16bc8cbcda424',
     x86_64: 'be67999ef4b05b90136fd8c0551473c3605046154127e62292bdfa0bd5c194af',
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
