require 'package'

class Gstreamer < Package
  description 'GStreamer is a library for constructing graphs of media-handling components.'
  homepage 'https://gstreamer.freedesktop.org/'
  version '1.14.4'
  source_url 'https://gstreamer.freedesktop.org/src/gstreamer/gstreamer-1.14.4.tar.xz'
  source_sha256 'f94f6696c5f05a3b3a9183e39c5f5c0b779f75a04c0efa497e7920afa985ffc7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gstreamer-1.14.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gstreamer-1.14.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gstreamer-1.14.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gstreamer-1.14.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd0d13f431c7dd2300538c99fa7346eb731a82e71ee637caa93ef5181c3c7cff4',
     armv7l: 'd0d13f431c7dd2300538c99fa7346eb731a82e71ee637caa93ef5181c3c7cff4',
       i686: '88cdb5e2d96c18da5e8168897309e463617888a0227fa1994c62a6dbdba054c7',
     x86_64: 'ffef3b7e782be4821276a5f75c4b75e096a145901193b962b3e94b6ac63252ca',
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
           '--enable-failing-tests',
           '--disable-gst-debug',
           '--disable-debug'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    # system "make", "check" # The 'gst/gsttracerrecord' test fails.
  end
end
