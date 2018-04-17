require 'package'

class Lld < Package
  description 'LLD is a linker from the LLVM project.'
  homepage 'https://lld.llvm.org/'
  version '6.0.0'
  source_url 'https://releases.llvm.org/6.0.0/lld-6.0.0.src.tar.xz'
  source_sha256 '6b8c4a833cf30230c0213d78dbac01af21387b298225de90ab56032ca79c0e0b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/lld-6.0.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/lld-6.0.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/lld-6.0.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/lld-6.0.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1be1bfd58802046614cd5a8edc5d665a042eeddfeae09e63b1f0e7993aab288f',
     armv7l: '1be1bfd58802046614cd5a8edc5d665a042eeddfeae09e63b1f0e7993aab288f',
       i686: '23154f25acc73cdddbacafe3b1a094d2d03a9e1500d8cb1c184793b58116893f',
     x86_64: '9e57137f1277f6216c1219460203d460344df61c37332a4129d0c97394bd4c25',
  })

  depends_on 'icu4c'
  depends_on 'llvm'
  
  def self.build
    system "mkdir -p builddir"
    Dir.chdir("builddir") do
      case ARCH
      when "x86_64"
        system "cmake",
               "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
               "-DLLVM_LIBDIR_SUFFIX=64",
               "-DBUILD_SHARED_LIBS=ON",
               "-DCMAKE_BUILD_TYPE=Release",
               ".."
      else
        system "cmake",
               "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
               "-DBUILD_SHARED_LIBS=ON",
               "-DCMAKE_BUILD_TYPE=Release",
               ".."
      end
      system "make"
    end
  end

  def self.install
    Dir.chdir("builddir") do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
