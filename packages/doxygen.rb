require 'package'

class Doxygen < Package
  description 'Doxygen is the de facto standard tool for generating documentation from annotated C++ sources, but it also supports other popular programming languages such as C, Objective-C, C#, PHP, Java, Python, IDL (Corba, Microsoft, and UNO/OpenOffice flavors), Fortran, VHDL, Tcl, and to some extent D.'
  homepage 'http://www.stack.nl/~dimitri/doxygen/'
  version '1.8.14'
  source_url 'https://github.com/doxygen/doxygen/archive/Release_1_8_14.tar.gz'
  source_sha256 '18bc3790b4d5f4d57cb8ee0a77dd63a52518f3f70d7fdff868a7ce7961a6edc3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/doxygen-1.8.14-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/doxygen-1.8.14-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/doxygen-1.8.14-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/doxygen-1.8.14-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a4e9e8bbade37410c9d055995070a50208e39bcec4ad4f00a180dc901c2fa5e0',
     armv7l: 'a4e9e8bbade37410c9d055995070a50208e39bcec4ad4f00a180dc901c2fa5e0',
       i686: '7e117bc6d09452cb8b271357dcdefb3484aed607de6b0cde60d5085b2d1e12d1',
     x86_64: '90eb469a28b5f7d058d90a93b21589a239edcc29059d397585e59f44d786f17d',
  })

  depends_on 'cmake' => :build
  depends_on 'python27' => :build

  def self.build
    system "mkdir -p build"
    Dir.chdir("build") do
      system "cmake",
             "-DCMAKE_INSTALL_PREFIX:PATH=#{CREW_PREFIX}",
             "-DCMAKE_LIBRARY_PATH=#{CREW_LIB_PREFIX}",
             ".."
      system "make"
    end
  end

  def self.install
    Dir.chdir("build") do
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
