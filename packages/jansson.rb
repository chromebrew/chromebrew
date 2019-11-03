require 'package'

class Jansson < Package
  description 'Jansson is a C library for encoding, decoding and manipulating JSON data.'
  homepage 'http://www.digip.org/jansson/'
  version '2.12'
  source_url 'https://github.com/akheron/jansson/archive/v2.12.tar.gz'
  source_sha256 '76260d30e9bbd0ef392798525e8cd7fe59a6450c54ca6135672e3cd6a1642941'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "cmake . -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}"
           #"-DJANSSON_INSTALL_CMAKE_DIR=#{ARCH_LIB}/cmake/jansson",
           #"-DJANSSON_INSTALL_LIB_DIR=#{ARCH_LIB}"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
