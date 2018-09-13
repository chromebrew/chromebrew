require 'package'

class Gstreamer < Package
  description 'Open source multimedia framework'
  homepage 'https://gstreamer.freedesktop.org/'
  version '1.14.2'
  source_url 'https://gstreamer.freedesktop.org/src/gstreamer/gstreamer-1.14.2.tar.xz'
  source_sha256 '4bd6127299f3f29379046bbd58a526e6353b569e0e72f7b4df2ae70df6882e09'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gstreamer-1.14.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gstreamer-1.14.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gstreamer-1.14.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gstreamer-1.14.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '361ed7db7f1971cfa3ca4583104b361902899bd9ee73eb2e42cf9f613815874e',
     armv7l: '361ed7db7f1971cfa3ca4583104b361902899bd9ee73eb2e42cf9f613815874e',
       i686: '92558c22f27f9bcd6646d09c4142b0f5d5b9065f18ed08ce853867473e06e064',
     x86_64: 'ee1184478d7caa6816714faa6651c30e2c1e74ae709944608453851144872fc4',
  })

  depends_on 'glib'
  depends_on 'gtk3'
  depends_on 'libunwind'
  depends_on 'python27'

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
