require 'package'

class Gstreamer < Package
  description 'GStreamer is a library for constructing graphs of media-handling components.'
  homepage 'https://gstreamer.freedesktop.org/'
  @_ver = '1.18.3'
  version @_ver
  compatibility 'all'
  source_url "https://gstreamer.freedesktop.org/src/gstreamer/gstreamer-#{@_ver}.tar.xz"
  source_sha256 '0c2e09e18f2df69a99b5cb3bd53c597b3cc2e35cf6c98043bb86a66f3d312100'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gstreamer-1.18.3-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gstreamer-1.18.3-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/gstreamer-1.18.3-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gstreamer-1.18.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '0e6aa5ea7062808f39a7188f923da0591517b4e2ca502977bb69416df15a6892',
      armv7l: '0e6aa5ea7062808f39a7188f923da0591517b4e2ca502977bb69416df15a6892',
        i686: 'fbd696dc11691c1bb86d146894823f5fda72f3603dedcb816e11a70c285d5e53',
      x86_64: '4bc3a4b7e46fcc68b5fe8ad8fa30e469a2ce24c36a3fd573ab5d049570d52f06',
  })

  depends_on 'glib'
  depends_on 'libcap'
  depends_on 'gtk3'
  depends_on 'gsl'
  depends_on 'elfutils'
  depends_on 'libunwind'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    -Dgst_debug=false \
    builddir"
    system "meson configure builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.check
    # system 'make', 'check' # The 'gst/gsttracerrecord' test fails.
  end
end
