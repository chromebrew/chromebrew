require 'package'

class Cloog < Package
  description 'The CLooG Code Generator in the Polytope Model'
  homepage 'https://github.com/periscop/cloog'
  version '0.20.0'
  compatibility 'all'
  source_url 'https://github.com/periscop/cloog/releases/download/cloog-0.20.0/cloog-0.20.0.tar.gz'
  source_sha256 '835c49951ff57be71dcceb6234d19d2cc22a3a5df84aea0a9d9760d92166fc72'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cloog-0.20.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cloog-0.20.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cloog-0.20.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cloog-0.20.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b776360d2fcfcd9eaf177250f7ad3ec4c128ef62b883f0f3234d696ef45335ca',
     armv7l: 'b776360d2fcfcd9eaf177250f7ad3ec4c128ef62b883f0f3234d696ef45335ca',
       i686: '5c6413aa59c93f8c25c86f4642b6311ed697e7305daeef9a35a6656b5a6e0694',
     x86_64: 'd31e2c02736dfa446b5058b4f947e2f6ed9a2aff0268adb616fedae1c716f012',
  })

  depends_on 'isl'
  depends_on 'osl'

  def self.patch
    system "sed -i -e '292,293d' -e '75,76d' configure.ac"
    system "sed -i -e '188,193d' Makefile.am"
  end

  def self.build
    system 'rm', '-rf', 'isl', 'osl'
    system 'mkdir', '-p', 'isl', 'osl'
    system 'rm', '-f', 'autoconf/ltmain.sh', 'm4/ltversion.m4'
    system 'autoreconf', '-i'
    system "./configure",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--with-isl=system",
           "--with-osl=system"
    system 'make'
  end

  def self.install
    system "make", "install", "DESTDIR=#{CREW_DEST_DIR}"
  end

  def self.check
    system 'make', 'check'
  end
end
