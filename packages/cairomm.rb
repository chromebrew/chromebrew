require 'package'

class Cairomm < Package
  description 'The Cairomm package provides a C++ interface to Cairo.'
  homepage 'https://www.cairographics.org/'
  version '1.15.5'
  source_url 'https://www.cairographics.org/releases/cairomm-1.15.5.tar.gz'
  source_sha256 '8db629f44378cac62b4931f725520334024e62c1951c4396682f1add63c1e3d1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cairomm-1.15.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cairomm-1.15.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cairomm-1.15.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cairomm-1.15.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '354736fee85a5bd242baa2663fadd0fdd55654f1533e2e2db5594d10483b4b9e',
     armv7l: '354736fee85a5bd242baa2663fadd0fdd55654f1533e2e2db5594d10483b4b9e',
       i686: '4cf3b5240a95a8a71510aa7cd2437cd1a85e53ecba1e7e3566a181586d73dcd7',
     x86_64: 'fb82422574a4bd2ef6a1c8613a8cf4d09ded07f2fa99bc530257fa21b599f9af',
  })

  depends_on 'cairo'
  depends_on 'libsigcplusplus'
  depends_on 'libxxf86vm'
  depends_on 'libxrender'
  depends_on 'gcc7' => :build

  def self.build
    system "sed -e '/^libdocdir =/ s/$(book_name)/cairomm-1.15.5/' \
    -i docs/Makefile.in"
    system "./configure",
           "CC=gcc-7.3",
           "CXX=g++-7.3",
           "CXXFLAGS=--std=c++14",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
 end

end
