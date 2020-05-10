require 'package'

class Vidstab < Package
  description 'Transcode video stabilization plugin.'
  homepage 'http://public.hronopik.de/vid.stab/'
  version '1.1.0-1'
  compatibility 'all'
  source_url 'https://github.com/georgmartius/vid.stab/archive/v1.1.0.tar.gz'
  source_sha256 '14d2a053e56edad4f397be0cb3ef8eb1ec3150404ce99a426c4eb641861dc0bb'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/vidstab-1.1.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/vidstab-1.1.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/vidstab-1.1.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/vidstab-1.1.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1f8dad35414c0ee16576445473791d9012ff3910d3a491b40d820adc05438eb2',
     armv7l: '1f8dad35414c0ee16576445473791d9012ff3910d3a491b40d820adc05438eb2',
       i686: '36dc191071129b11a10eed98042c06b17dd2d41dccbddc0995da11a5a6fdb7d8',
     x86_64: 'c722ad0d35766647406425bd512bf05058909045634b75ec42450fe3b42e4592',
  })

  def self.build
    if ARCH == 'x86_64'
      system "cmake -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} -DLIB_SUFFIX=64"
    else
      system "cmake -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}"
    end
    system 'make'
  end

  def self.install
    system "make", "LIBDIR=#{CREW_LIB_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
