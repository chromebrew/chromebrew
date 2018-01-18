require 'package'

class Llvm_polly < Package
  description 'Polly is a high-level loop and data-locality optimizer and optimization infrastructure for LLVM.'
  homepage 'https://polly.llvm.org/'
  version '5.0.1'
  source_url 'https://releases.llvm.org/5.0.1/polly-5.0.1.src.tar.xz'
  source_sha256 '9dd52b17c07054aa8998fc6667d41ae921430ef63fa20ae130037136fdacf36e'

  depends_on 'cmake' => :build
  depends_on 'llvm'

  def self.build
    Dir.mkdir 'mybuilddir'
    Dir.chdir "mybuilddir" do
      system "cmake -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Release .."
      system "cmake --build . --  -j#{CREW_NPROC}"
    end
  end

  def self.install
    Dir.chdir "mybuilddir" do
      system "cmake -DCMAKE_INSTALL_PREFIX=#{CREW_DEST_PREFIX} -P cmake_install.cmake"
    end
  end
end
