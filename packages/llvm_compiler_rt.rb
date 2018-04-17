require 'package'

class Llvm_compiler_rt < Package
  description 'Part of the LLVM project.'
  homepage 'https://compiler-rt.llvm.org/'
  version '6.0.0'
  source_url 'http://releases.llvm.org/6.0.0/compiler-rt-6.0.0.src.tar.xz'
  source_sha256 'd0cc1342cf57e9a8d52f5498da47a3b28d24ac0d39cbc92308781b3ee0cea79a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/llvm_compiler_rt-6.0.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/llvm_compiler_rt-6.0.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/llvm_compiler_rt-6.0.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/llvm_compiler_rt-6.0.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '78d7bd2c47789d3e19e35d3a5f23cc7ff85509a9e86a6cca4fbed9c99fa1f52b',
     armv7l: '78d7bd2c47789d3e19e35d3a5f23cc7ff85509a9e86a6cca4fbed9c99fa1f52b',
       i686: 'c9bdb1c5819571139cced1615373a51694bf0829815143f0a1552708e4a53764',
     x86_64: '5ac574941affdeeedd11124b0c02504e74b0af59ee1661baf182acf267706328',
  })

  depends_on 'llvm'
  
  def self.build
    system "mkdir -p builddir"
    Dir.chdir("builddir") do
      system "cmake",
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             "-DBUILD_SHARED_LIBS=ON",
             "-DCMAKE_BUILD_TYPE=Release",
             ".."
      system "make"
    end
  end

  def self.install                 # the steps required to install the package
    Dir.chdir("builddir") do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
  
end
