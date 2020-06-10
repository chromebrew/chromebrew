require 'package'

class Gstreamer < Package
  description 'GStreamer is a library for constructing graphs of media-handling components.'
  homepage 'https://gstreamer.freedesktop.org/'
  version '1.16.0'
  compatibility 'all'
  source_url 'https://gstreamer.freedesktop.org/src/gstreamer/gstreamer-1.16.0.tar.xz'
  source_sha256 '0e8e2f7118be437cba879353970cf83c2acced825ecb9275ba05d9186ef07c00'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gstreamer-1.16.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gstreamer-1.16.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gstreamer-1.16.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gstreamer-1.16.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '893b56afd71e7b245fe73899569579d9eb9f7f580612b1f35516045d8ac0ff88',
     armv7l: '893b56afd71e7b245fe73899569579d9eb9f7f580612b1f35516045d8ac0ff88',
       i686: 'c99a01dc6368256e71bda4b73c01b59ea989a176f07ebb16144999c5f825c77a',
     x86_64: '5e54e1d4fb7b4468f7dc8ecfb0bcdeb06b96796d5b5425e46f45fb3545ccb7a1',
  })

  depends_on 'glib'
  depends_on 'libcap'
  depends_on 'gtk3'
  depends_on 'gsl'
  depends_on 'elfutils'
  depends_on 'libunwind'
  depends_on 'python27'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode',
           '--enable-failing-tests',
           '--disable-gst-debug',
           '--disable-debug'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    # system 'make', 'check' # The 'gst/gsttracerrecord' test fails.
  end
end
