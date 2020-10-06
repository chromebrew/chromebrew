require 'package'

class Libwebp < Package
  description 'WebP is a modern image format that provides superior lossless and lossy compression for images on the web.'
  homepage 'https://developers.google.com/speed/webp/'
  version '1.1.0'
  compatibility 'all'
  source_url 'https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-1.1.0.tar.gz'
  source_sha256 '98a052268cc4d5ece27f76572a7f50293f439c17a98e67c4ea0c7ed6f50ef043'

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
