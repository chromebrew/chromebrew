require 'package'

class Lld < Package
  description 'LLD is a linker from the LLVM project.'
  homepage 'https://lld.llvm.org/'
  version '5.0.1'
  source_url 'https://releases.llvm.org/5.0.1/lld-5.0.1.src.tar.xz'
  source_sha256 'd5b36c0005824f07ab093616bdff247f3da817cae2c51371e1d1473af717d895'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/lld-5.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/lld-5.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/lld-5.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/lld-5.0.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e1dedfb748082eb7ff810a8aa364819e6a11042d287ae7b3f885c85ec81f3dd9',
     armv7l: 'e1dedfb748082eb7ff810a8aa364819e6a11042d287ae7b3f885c85ec81f3dd9',
       i686: '8b918b4fe1888106a4b5502195b5a0a3acd21f9b239424459f5db820eda0f5b2',
     x86_64: 'fc302a4bc537ec67b219da45a3bc19ca4fb398ba581e70a4fc11a66a84496f78',
  })

  depends_on 'cmake' => :build

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
