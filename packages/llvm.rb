require 'package'

class Llvm < Package
  description 'The LLVM Project is a collection of modular and reusable compiler and toolchain technologies.'
  homepage 'http://llvm.org/'
  version '3.8.1-1'
  source_url 'http://llvm.org/releases/3.8.1/llvm-3.8.1.src.tar.xz'
  source_sha256 '6e82ce4adb54ff3afc18053d6981b6aed1406751b8742582ed50f04b5ab475f9'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/llvm-3.8.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/llvm-3.8.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/llvm-3.8.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/llvm-3.8.1-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '94255baa409229bbd0ad5f23981ee807fc39cb0c5160451daa0c3bfb1ebb78ae',
     armv7l: '94255baa409229bbd0ad5f23981ee807fc39cb0c5160451daa0c3bfb1ebb78ae',
       i686: '1d906912c090feeb81bb1777b8ff1ec7dcdadea08adea68c8a9cf9dfdcd8f2bb',
     x86_64: 'efd72e40446eb7fb266b39a2e20df8398846ed76c96197b65dd31cb0fe023438',
  })

  depends_on 'buildessential'
  depends_on 'cmake'

  def self.build
    system "mkdir mybuilddir"
    Dir.chdir "mybuilddir" do
 	    system "cmake .. -DLLVM_BUILD_LLVM_DYLIB=true"
    	system "cmake --build ."
    end
  end

  def self.install
    Dir.chdir "mybuilddir" do
       system "cmake -DCMAKE_INSTALL_PREFIX=#{CREW_DEST_DIR}/usr/local -P cmake_install.cmake"
    end
  end
end
