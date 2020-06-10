require 'package'

class Libqmi < Package
  description 'libqmi is a glib-based library for talking to WWAN modems and devices which speak the Qualcomm MSM Interface (QMI) protocol.'
  homepage 'https://www.freedesktop.org/wiki/Software/libqmi/'
  version '1.20.2'
  compatibility 'all'
  source_url 'https://www.freedesktop.org/software/libqmi/libqmi-1.20.2.tar.xz'
  source_sha256 'c73459ca8bfe1213f8047858d4946fc1f58e164d4f488a7a6904edee25e2ca44'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libqmi-1.20.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libqmi-1.20.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libqmi-1.20.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libqmi-1.20.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '30dc112b0c02bec117a00a1a72684d34b4db6e5c60f5ffdbdcac7701b962e23d',
     armv7l: '30dc112b0c02bec117a00a1a72684d34b4db6e5c60f5ffdbdcac7701b962e23d',
       i686: 'a9e7760a7345e09368cfe8655923e27f8fc534179bbc003afef6eb18c5fa1533',
     x86_64: 'e52b18b3f21c9cbe69609e0c0c351ac8e7231c6ac29792d9f360451724818019',
  })

  depends_on 'libgudev'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
