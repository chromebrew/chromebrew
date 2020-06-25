require 'package'

class Mono < Package
  description 'Mono is a software platform designed to allow developers to easily create cross platform applications part of the .NET Foundation.'
  homepage 'http://www.mono-project.com/'
  version '6.8.0.123'
  compatibility 'all'
  source_url 'https://download.mono-project.com/sources/mono/mono-6.8.0.123.tar.xz'
  source_sha256 'e2e42d36e19f083fc0d82f6c02f7db80611d69767112af353df2f279744a2ac5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mono-6.8.0.123-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mono-6.8.0.123-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mono-6.8.0.123-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mono-6.8.0.123-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e149fae5b52de42513f903eebcf3dc3a9690d055554a2a699522225207628874',
     armv7l: 'e149fae5b52de42513f903eebcf3dc3a9690d055554a2a699522225207628874',
       i686: '4c05f5517336de0eab70ca765a6d26ccd96ea2e11d654ad556d8f6953ad684d1',
     x86_64: 'd0ec517b0bc3eafd6a8b0fb22fbf53d97152ce3ade5920a95153c392b7dbae1e',
  })

  def self.build
    system "./configure #{CREW_OPTIONS} --disable-dependency-tracking --disable-maintainer-mode --disable-silent-rules --enable-nls=no"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.ln_sf "#{CREW_PREFIX}/bin/#{CREW_BUILD}-mono-sgen", "#{CREW_DEST_PREFIX}/bin/mono"
    FileUtils.ln_sf "#{CREW_MAN_PREFIX}/man1/#{CREW_BUILD}-mono.1.gz", "#{CREW_DEST_MAN_PREFIX}/man1/mono.1.gz"
  end
end
