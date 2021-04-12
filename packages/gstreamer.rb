require 'package'

class Gstreamer < Package
  description 'GStreamer is a library for constructing graphs of media-handling components.'
  homepage 'https://gstreamer.freedesktop.org/'
  @_ver = '1.18.4'
  version @_ver
  license 'LGPL-2+'
  compatibility 'all'
  source_url "https://gstreamer.freedesktop.org/src/gstreamer/gstreamer-#{@_ver}.tar.xz"
  source_sha256 '9aeec99b38e310817012aa2d1d76573b787af47f8a725a65b833880a094dfbc5'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gstreamer-1.18.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gstreamer-1.18.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gstreamer-1.18.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gstreamer-1.18.4-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '6c9267fa671cd0127e8f677e211b3b260d79f85e865b7e9e98bdcfd726360e5a',
     armv7l: '6c9267fa671cd0127e8f677e211b3b260d79f85e865b7e9e98bdcfd726360e5a',
       i686: 'd38f98eeff929f20a089fa31fb8f39ab35dfef882b2179e68779488f22de88e1',
     x86_64: '3754e3981352103d7f02b66ea1c8784e01317092c2f313462e9ac7dea7d1c288'
  })

  depends_on 'elfutils'
  depends_on 'glib'
  depends_on 'gsl'
  depends_on 'gtk3'
  depends_on 'libcap'
  depends_on 'libunwind'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    -Dgst_debug=false \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.check
    # system 'make', 'check' # The 'gst/gsttracerrecord' test fails.
  end
end
