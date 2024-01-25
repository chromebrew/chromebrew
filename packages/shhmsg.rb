require 'package'

class Shhmsg < Package
  description 'C-functions for error messages, verbose messages and \'normal\' messages in terminal-based programs.'
  homepage 'http://shh.thathost.com/pub-unix/#sshmsg'
  version '1.4.2-2'
  license 'Artistic'
  compatibility 'all'
  source_url 'http://shh.thathost.com/pub-unix/files/shhmsg-1.4.2.tar.gz'
  source_sha256 '88c69e3f0b920b1ef93f6c10f354786f171d7cb3ab170a463bb9ab8bbf13a02b'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '6b4a11be7742dc0936b3f85638c337c0af8a2b08a3c46c7e320604341a8ca707',
     armv7l: '6b4a11be7742dc0936b3f85638c337c0af8a2b08a3c46c7e320604341a8ca707',
       i686: 'a4f4dd74cd2a4e437433366c43a9c03e928e69e863e8affce144c3d68d070bc0',
     x86_64: '8b931183312312ca51ebc29d9e9a3c87d64212a561dfbee32446c93ea8126c96'
  })

  def self.patch
    `sed -i 's/.*SHARED.*0.*/SHARED=1/' Makefile` # enable shared
  end

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "INSTBASEDIR=#{CREW_DEST_PREFIX}", "INSTLIBDIR=#{CREW_DEST_LIB_PREFIX}", 'install'
  end
end
