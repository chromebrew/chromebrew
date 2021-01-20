require 'package'

class Libsoxr < Package
  description 'High quality, one-dimensional sample-rate conversion library.'
  homepage 'https://sourceforge.net/projects/soxr/'
  version '0.1.3-1'
  compatibility 'all'
  source_url 'http://downloads.sourceforge.net/project/soxr/soxr-0.1.3-Source.tar.xz'
  source_sha256 'b111c15fdc8c029989330ff559184198c161100a59312f5dc19ddeb9b5a15889'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libsoxr-0.1.3-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libsoxr-0.1.3-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libsoxr-0.1.3-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libsoxr-0.1.3-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e4f9d134c15ee05ceb89a70f0b660dca0425ea4365d5c1f1fb288f55e314064c',
     armv7l: 'e4f9d134c15ee05ceb89a70f0b660dca0425ea4365d5c1f1fb288f55e314064c',
       i686: '37088510fc2195e185475bcaa0ffa778feae8e8157188047328d93164b446fce',
     x86_64: '4a850aee3eedd80b601cb1d5bb06b6b06844a3a09423a22f264b7437fbf5eee1',
  })

  def self.build
    if ARCH == "x86_64"
      system "cmake",
             "-DPREFIX=#{CREW_PREFIX}",
             "-DLIB_SUFFIX=64",
             "-DBUILD_SHARED_LIBS=ON",
             "-DCMAKE_C_FLAGS=-g -O2 -fPIC",
             "."
    else
      system "cmake",
             "-DPREFIX=#{CREW_PREFIX}",
             "-DBUILD_SHARED_LIBS=ON",
             "-DCMAKE_C_FLAGS=-g -O2 -fPIC",
             "."
    end
    system "make"
  end

  def self.check
    system "make check"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
