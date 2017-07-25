require 'package'

class Llvm < Package
  description 'The LLVM Project is a collection of modular and reusable compiler and toolchain technologies.'
  homepage 'http://llvm.org/'
  version '3.8.1-1'
  source_url 'http://llvm.org/releases/3.8.1/llvm-3.8.1.src.tar.xz'
  source_sha256 '6e82ce4adb54ff3afc18053d6981b6aed1406751b8742582ed50f04b5ab475f9'

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
