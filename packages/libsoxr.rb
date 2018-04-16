require 'package'

class Libsoxr < Package
  description 'High quality, one-dimensional sample-rate conversion library.'
  homepage 'https://sourceforge.net/projects/soxr/'
  version '0.1.3'
  source_url 'https://sourceforge.net/projects/soxr/files/soxr-0.1.3-Source.tar.xz'
  source_sha256 'b111c15fdc8c029989330ff559184198c161100a59312f5dc19ddeb9b5a15889'

  depends_on 'cmake' => :build

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
