require 'package'

class Gstreamer < Package
  description 'GStreamer is a library for constructing graphs of media-handling components.'
  homepage 'https://gstreamer.freedesktop.org/'
  version '1.18.0'
  compatibility 'all'
  source_url 'https://gstreamer.freedesktop.org/src/gstreamer/gstreamer-1.18.0.tar.xz'
  source_sha256 '0ff09245b06c0aeb5d9a156edcab088a7e8213a0bf9c84a1ff0318f9c00c7805'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gstreamer-1.18.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gstreamer-1.18.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gstreamer-1.18.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gstreamer-1.18.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0dca199353177541752ce291d76979019b80af95dfa7c9499fdb992010a19151',
     armv7l: '0dca199353177541752ce291d76979019b80af95dfa7c9499fdb992010a19151',
       i686: '5de8acc27668a03cbf674589bbb840848212afa265657ef0054f2c037ab08702',
     x86_64: '2a9044b75cf3d305675486a951054cf792495f7baeb38eab27fa1aa5f6b50bf7',
  })

  depends_on 'glib'
  depends_on 'libcap'
  depends_on 'gtk3'
  depends_on 'gsl'
  depends_on 'elfutils'
  depends_on 'libunwind'
  depends_on 'python27'

  def self.build
    # Use lld for ChromOS library compatibility
    #ENV['CFLAGS'] = "-fuse-ld=lld"
    #ENV['CXXFLAGS'] = "-fuse-ld=lld"
    system "meson",
    "--prefix=#{CREW_PREFIX}",
    "--libdir=#{CREW_LIB_PREFIX}",
    "-Dgst_debug=false",
    "build"
    system "ninja -C build"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end

  def self.check
    # system 'make', 'check' # The 'gst/gsttracerrecord' test fails.
  end
end
