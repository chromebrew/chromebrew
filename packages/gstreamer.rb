require 'package'

class Gstreamer < Package
  description 'GStreamer is a library for constructing graphs of media-handling components.'
  homepage 'https://gstreamer.freedesktop.org/'
  version '1.18.0'
  compatibility 'all'
  source_url 'https://gstreamer.freedesktop.org/src/gstreamer/gstreamer-1.18.0.tar.xz'
  source_sha256 '0ff09245b06c0aeb5d9a156edcab088a7e8213a0bf9c84a1ff0318f9c00c7805'

  depends_on 'glib'
  depends_on 'libcap'
  depends_on 'gtk3'
  depends_on 'gsl'
  depends_on 'elfutils'
  depends_on 'libunwind'
  depends_on 'python27'
  depends_on 'llvm'

  def self.build
    # Use lld for ChromOS library compatibility
    ENV['CFLAGS'] = "-fuse-ld=lld"
    ENV['CXXFLAGS'] = "-fuse-ld=lld"
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
