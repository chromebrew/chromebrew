require 'package'

class Libomxil_bellagio < Package
  description 'Bellagio is an opensource implementation of the Khronos OpenMAX Integration Layer API to access multimedia components.'
  homepage 'https://sourceforge.net/projects/aa-project/'
  version '0.9.3'
  compatibility 'all'
  source_url 'https://sourceforge.net/projects/omxil/files/omxil/Bellagio%200.9.3/libomxil-bellagio-0.9.3.tar.gz'
  source_sha256 '593c0729c8ef8c1467b3bfefcf355ec19a46dd92e31bfc280e17d96b0934d74c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libomxil_bellagio-0.9.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libomxil_bellagio-0.9.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libomxil_bellagio-0.9.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libomxil_bellagio-0.9.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0980aac0bbb655e74b155b2237df8ca0b36b5264c29f32201e259275fd78743f',
     armv7l: '0980aac0bbb655e74b155b2237df8ca0b36b5264c29f32201e259275fd78743f',
       i686: 'dd7090697141eafc848e8945e2f586c410c821095036e14f13b4c64989bf40f2',
     x86_64: 'cd7d8593f02b09c941efba9899c0e6eb3382d9490d0752de5785fdf8a4437ba3',
  })

  def self.build
    system "./configure","--prefix=#{CREW_PREFIX}","--libdir=#{CREW_LIB_PREFIX}"
    system "make", "-j1", "CFLAGS=-Wno-error=switch"    # only -j1 possible (tested on armv7l)
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "cp -r #{CREW_DEST_DIR}#{CREW_DEST_DIR}/* #{CREW_DEST_DIR}/"
    system "rm -rf #{CREW_DEST_DIR}#{CREW_DEST_DIR}/"
  end
end
