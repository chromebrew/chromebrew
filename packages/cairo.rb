require 'package'

class Cairo < Package
  description 'Cairo is a 2D graphics library with support for multiple output devices.'
  homepage 'https://www.cairographics.org'
  version '1.16.0'
  source_url 'https://www.cairographics.org/releases/cairo-1.16.0.tar.xz'
  source_sha256 '5e7b29b3f113ef870d1e3ecf8adf21f923396401604bda16d44be45e66052331'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libpng'
  depends_on 'pixman'
  depends_on 'fontconfig'
  depends_on 'libtool'
  depends_on 'mesa'

  def self.build
    system './configure',
           '--enable-ft',
           '--enable-fc',
           '--enable-xml',
           '--enable-tee',
           '--enable-xcb',
           '--enable-egl',
           '--enable-xlib',
           '--enable-glesv3',
           '--enable-gobject',
           '--enable-pthread',
           '--enable-xcb-shm',
           '--enable-xlib-xcb',
           '--enable-xlib-xrender',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
