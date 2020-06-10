require 'package'

class Libwacom < Package
  description 'libwacom is a wrapper library for evdev devices.'
  homepage 'http://linuxwacom.sourceforge.net/wiki/index.php/Libwacom'
  version '0.28-0'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/linuxwacom/libwacom-0.28.tar.bz2'
  source_sha256 'e7d632301288b221cb5af69b4c5e57fd062bafd9a9acd6f9ce271570103267ef'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libwacom-0.28-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libwacom-0.28-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libwacom-0.28-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libwacom-0.28-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '90853f518d643be9a53e4d8edd6f826156cc64189807a3565bffda8411fe9636',
     armv7l: '90853f518d643be9a53e4d8edd6f826156cc64189807a3565bffda8411fe9636',
       i686: 'cdd52b3f2c8a40be5907213be1861308ed53194a25b7b3afa9ca7e365025e741',
     x86_64: '2ffb5dbd3620667a758b6e66f42a339474cdc9363bb942a8a696bc952b486b0b',
  })

  depends_on 'libgudev'
  depends_on 'eudev'
       
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
