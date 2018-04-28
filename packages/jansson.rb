require 'package'

class Jansson < Package
  description 'Jansson is a C library for encoding, decoding and manipulating JSON data.'
  homepage 'http://www.digip.org/jansson/'
  version '2.11'
  source_url 'https://github.com/akheron/jansson/archive/v2.11.tar.gz'
  source_sha256 '6ff0eab3a8baf64d21cae25f88a0311fb282006eb992080722a9099469c32881'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/jansson-2.11-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/jansson-2.11-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/jansson-2.11-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/jansson-2.11-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c2cdc0bf928cc44d8e8b99dce354f838fef6008fd3a65f0fc1171077c3c4238d',
     armv7l: 'c2cdc0bf928cc44d8e8b99dce354f838fef6008fd3a65f0fc1171077c3c4238d',
       i686: '318d31c65a9c07a25a1984959eed6e7d88ea2b9f35b4722209ad4c2363d772cf',
     x86_64: 'e71aeaec54d731aa0524cc33e88329713a0d072d6e5f4bb8e76bd7bdc634bd6c',
  })

  def self.build
    system "cmake . -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}"
           #"-DJANSSON_INSTALL_CMAKE_DIR=#{ARCH_LIB}/cmake/jansson",
           #"-DJANSSON_INSTALL_LIB_DIR=#{ARCH_LIB}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
