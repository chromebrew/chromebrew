require 'package'

class Openblas < Package
  description 'OpenBLAS is an optimized BLAS library'
  homepage 'http://www.openblas.net/'
  version '0.3.10'
  compatibility 'all'
  source_url 'https://github.com/xianyi/OpenBLAS/archive/v0.3.10.tar.gz'
  source_sha256 '0484d275f87e9b8641ff2eecaa9df2830cbe276ac79ad80494822721de6e1693'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/openblas-0.3.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/openblas-0.3.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/openblas-0.3.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/openblas-0.3.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0d21d2d1b5de2552db9b2b3f40acf217b1e634181fe052e430d8e7421d53f4c3',
     armv7l: '0d21d2d1b5de2552db9b2b3f40acf217b1e634181fe052e430d8e7421d53f4c3',
       i686: 'f4ce053cc07aa55bd77f4078eaf7875f5f9dfb266e2faa450ed823e62cc0ef16',
     x86_64: '5ff79ee03d58af432aa664986c4128cc3e8ec95b9e16ced015f48acb8edb4f3c',
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
