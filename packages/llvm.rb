require 'package'

class Llvm < Package
  version '3.8.1-1'
  source_url 'http://llvm.org/releases/3.8.1/llvm-3.8.1.src.tar.xz'
  source_sha1 'e0c48c4c182424b99999367d688cd8ce7876827b'

  depends_on 'buildessential'
  depends_on 'cmake'

  def self.build
    system "mkdir mybuilddir"
    Dir.chdir CREW_BREW_DIR+"llvm-"+version+".src/mybuilddir" do
 	system "cmake .."
    	system "cmake --build ."
    end
  end

  def self.install
    Dir.chdir CREW_BREW_DIR+"llvm-"+version+".src/mybuilddir" do
       system "cmake -DCMAKE_INSTALL_PREFIX=#{CREW_DEST_DIR}/usr/local -P cmake_install.cmake"
    end  
  end
end
