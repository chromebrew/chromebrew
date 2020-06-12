require 'package'

class Cairo < Package
  description 'Cairo is a 2D graphics library with support for multiple output devices.'
  homepage 'https://www.cairographics.org'
  version '1.16.0'
  compatibility 'all'
  source_url 'https://www.cairographics.org/releases/cairo-1.16.0.tar.xz'
  source_sha256 '5e7b29b3f113ef870d1e3ecf8adf21f923396401604bda16d44be45e66052331'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cairo-1.16.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cairo-1.16.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cairo-1.16.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cairo-1.16.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8c6ac7612bd9aac77a38fa2a6bc519ff3f0bc94e46cd3fd5d0f75c68e41876e4',
     armv7l: '8c6ac7612bd9aac77a38fa2a6bc519ff3f0bc94e46cd3fd5d0f75c68e41876e4',
       i686: '93e54aec50db4895b4897745b89d7f3876ba25fb1941333063fd1ec335a0977a',
     x86_64: '0f0655202da77ecbcd2259a0f6367ac5f33fffb8e2af3698ea652967b2926461',
  })

  depends_on 'libpng'
  depends_on 'lzo'
  depends_on 'pixman'
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
