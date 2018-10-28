require 'package'

class Gstreamer < Package
  description 'GStreamer is a library for constructing graphs of media-handling components.'
  homepage 'https://gstreamer.freedesktop.org/'
  version '1.14.4'
  source_url 'https://gstreamer.freedesktop.org/src/gstreamer/gstreamer-1.14.4.tar.xz'
  source_sha256 'f94f6696c5f05a3b3a9183e39c5f5c0b779f75a04c0efa497e7920afa985ffc7'

  binary_url ({
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gstreamer-1.14.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     x86_64: '3242ab5a7000360604c49f15e6ba3abd41710cb6e7ced873ba689923aa7552ea',
  })

  depends_on 'glib'
  depends_on 'libcap'
  depends_on 'gtk3'
  depends_on 'gsl'
  depends_on 'libunwind'
  depends_on 'python27'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--enable-failing-tests"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
