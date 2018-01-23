require 'package'

class Llvm_polly < Package
  description 'Polly is a high-level loop and data-locality optimizer and optimization infrastructure for LLVM.'
  homepage 'https://polly.llvm.org/'
  version '5.0.1'
  source_url 'https://releases.llvm.org/5.0.1/polly-5.0.1.src.tar.xz'
  source_sha256 '9dd52b17c07054aa8998fc6667d41ae921430ef63fa20ae130037136fdacf36e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/llvm_polly-5.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/llvm_polly-5.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/llvm_polly-5.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/llvm_polly-5.0.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '95cbd284074b90f16ef6ea0edcce09891755ee2899d365aa740d13381d946e27',
     armv7l: '95cbd284074b90f16ef6ea0edcce09891755ee2899d365aa740d13381d946e27',
       i686: 'a1cb32da5a3be40dac922a183916f1f9b272ed13d1b3e2e423f86bf22c6233fd',
     x86_64: 'c13578626869492510bbfacc68ac9b005cd2d3708a7cbc9d634c6b6e6340bbe2',
  })

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
