require 'package'

class Isl < Package
  description 'Integer Set Library for manipulating sets and relations of integer points bounded by linear constraints'
  homepage 'http://isl.gforge.inria.fr/'
  version '0.20-1'
  source_url 'http://isl.gforge.inria.fr/isl-0.20.tar.xz'
  source_sha256 'a5596a9fb8a5b365cb612e4b9628735d6e67e9178fae134a816ae195017e77aa'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "mkdir -p #{CREW_DEST_LIB_PREFIX}"
    system "ln -s #{CREW_LIB_PREFIX}/libisl.so.19.1.0 #{CREW_DEST_LIB_PREFIX}/libisl.so.15"
  end

  def self.check
    system 'make', 'check'
  end
end
