require 'package'

class Openblas < Package
  description 'OpenBLAS is an optimized BLAS library'
  homepage 'http://www.openblas.net/'
  version '0.2.20'
  compatibility 'all'
  source_url 'https://github.com/xianyi/OpenBLAS/archive/v0.2.20.tar.gz'
  source_sha256 '5ef38b15d9c652985774869efd548b8e3e972e1e99475c673b25537ed7bcf394'

  binary_url ({
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/openblas-0.2.20-chromeos-x86_64.tar.xz',
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/openblas-0.2.20-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/openblas-0.2.20-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/openblas-0.2.20-chromeos-i686.tar.xz',
  })
  binary_sha256 ({
     x86_64: '4f26162240cb8dd302093465f0820f5f19b173664f024bd4fde041f0e7814889',
    aarch64: '5240dd476ce2151fd6d8b8a249905c86985da6511cf0266afc0bf1b0385a6873',
     armv7l: '5240dd476ce2151fd6d8b8a249905c86985da6511cf0266afc0bf1b0385a6873',
       i686: 'b0ef5a6983cbff487c88de790888c48b1aca6720be6b129a8f19b0a7303f56b9',
  })

  def self.build
    case ARCH
    when "x86_64"
      system "mkdir -p build"
      Dir.chdir("build") do
        system "cmake",
               "-DCMAKE_INSTALL_PREFIX:PATH=#{CREW_PREFIX}",
               "-DCMAKE_LIBRARY_PATH=#{CREW_LIB_PREFIX}",
               "TARGET=ATOM",
               ".."
        system "make"
      end
    when "i686"
      system "make TARGET=ATOM"
    when "armv7l","aarch64"
      system "make TARGET=ARMV7"
    end
  end

  def self.install
    case ARCH
    when "x86_64"
      Dir.chdir("build") do
        system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
      end
    when "i686","armv7l","aarch64"
      system "make",
             "PREFIX=#{CREW_PREFIX}",
             "DESTDIR=#{CREW_DEST_DIR}",
             "install"
    end
  end
end
