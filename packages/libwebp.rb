require 'package'

class Libwebp < Package
  description 'WebP is a modern image format that provides superior lossless and lossy compression for images on the web.'
  homepage 'https://developers.google.com/speed/webp/'
  version '0.6.1-1'
  compatibility 'all'
  source_url 'https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-0.6.1.tar.gz'
  source_sha256 '06503c782d9f151baa325591c3579c68ed700ffc62d4f5a32feead0ff017d8ab'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libwebp-0.6.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libwebp-0.6.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libwebp-0.6.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libwebp-0.6.1-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e3ed2610bccfd53bc87a97989fde7bf4b3c6225b96d3be0072417e02004fe868',
     armv7l: 'e3ed2610bccfd53bc87a97989fde7bf4b3c6225b96d3be0072417e02004fe868',
       i686: '7eb78db5b9fdd52a9a3b740fe46bf9002d3cbd91960825d02b55c860c6d0dbbb',
     x86_64: 'f1e466cecf4b6658eb9c604ae3ca388fa22d54b1fab2493e862f7b3a65640e74',
  })

  depends_on 'libpng'
  depends_on 'libsdl'
  depends_on 'libtiff'
  depends_on 'mesa'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--enable-libwebpmux',
           '--enable-libwebpdemux',
           '--enable-libwebpdecoder',
           '--enable-libwebpextras'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
