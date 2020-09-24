require 'package'

class Xercesc < Package
  description 'Xerces-C++ is a validating XML parser written in a portable subset of C++.'
  homepage 'http://xerces.apache.org/xerces-c/'
  version '3.2.3'
  compatibility 'all'
  source_url 'https://downloads.apache.org/xerces/c/3/sources/xerces-c-3.2.3.tar.xz'
  source_sha256 '12fc99a9fc1d1a79bd0e927b8b5637a576d6656f45b0d5e70ee3694d379cc149'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xercesc-3.2.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xercesc-3.2.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xercesc-3.2.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xercesc-3.2.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7ee70737c8d3fe7d21a9e3cf3f27abebcf9b663da95b4aa24e9862c9c707fe4c',
     armv7l: '7ee70737c8d3fe7d21a9e3cf3f27abebcf9b663da95b4aa24e9862c9c707fe4c',
       i686: '8cad0d974c6c6966fbc7e0d039fcab63a07eccd4e2435fadd748b4fbce2e5cc4',
     x86_64: 'd1a0c7fd791b712963ea851792e8253474ec0ba5683d631ce0b0ac981e90762e',
  })

  depends_on 'curl'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode',
           '--disable-static'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
