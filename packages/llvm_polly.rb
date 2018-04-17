require 'package'

class Llvm_polly < Package
  description 'Polly is a high-level loop and data-locality optimizer and optimization infrastructure for LLVM.'
  homepage 'https://polly.llvm.org/'
  version '6.0.0'
  source_url 'https://releases.llvm.org/6.0.0/polly-6.0.0.src.tar.xz'
  source_sha256 '47e493a799dca35bc68ca2ceaeed27c5ca09b12241f87f7220b5f5882194f59c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/llvm_polly-6.0.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/llvm_polly-6.0.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/llvm_polly-6.0.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/llvm_polly-6.0.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6cbcf1f4b4be8436cb8777b4901415a3b4491245bd0cf1c91282f5a0fcbc4695',
     armv7l: '6cbcf1f4b4be8436cb8777b4901415a3b4491245bd0cf1c91282f5a0fcbc4695',
       i686: 'bc820d67a82ca545669b8c19abd689fce9013ae4a2d3ed906a2334c24ac31b63',
     x86_64: '2c871c0b3f35f4102f473c286c84d3ef8e2549749906dcdab8c6925ea1a6eb3a',
  })

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
               "-DLLVM_FILECHECK=ON",
               "-DLLVM_NOT=ON",
               ".."
      else
        system "cmake",
               "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
               "-DBUILD_SHARED_LIBS=ON",
               "-DCMAKE_BUILD_TYPE=Release",
               "-DLLVM_FILECHECK=ON",
               "-DLLVM_NOT=ON",
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
