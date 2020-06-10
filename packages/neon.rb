require 'package'

class Neon < Package
  description 'neon is an HTTP and WebDAV client library, with a C interface.'
  homepage 'http://www.webdav.org/neon/'
  version '0.30.2'
  compatibility 'all'
  source_url 'http://www.webdav.org/neon/neon-0.30.2.tar.gz'
  source_sha256 'db0bd8cdec329b48f53a6f00199c92d5ba40b0f015b153718d1b15d3d967fbca'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/neon-0.30.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/neon-0.30.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/neon-0.30.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/neon-0.30.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '788d09916ce56e217297af5f3e3ce86d131ab05be0f54f85bf24f86a85701989',
     armv7l: '788d09916ce56e217297af5f3e3ce86d131ab05be0f54f85bf24f86a85701989',
       i686: 'a6777a6aa2be12f78be08c1af13ec49116d44b0c0f2fe892dd8ebd443f6b26e6',
     x86_64: '6ced539e58a179d141a242cea0a265a1d1897320346694639d192b5a83c1d59c',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--enable-shared=yes',
           '--enable-static=no',
           '--with-ssl=openssl'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libneon.so", "#{CREW_DEST_LIB_PREFIX}/neon.so"
  end
end
