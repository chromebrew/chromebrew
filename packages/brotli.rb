require 'package'

class Brotli < Package
  description 'Brotli compression format '
  homepage 'https://github.com/google/brotli'
  version '1.0.2'
  source_url 'https://github.com/google/brotli/archive/v1.0.2.tar.gz'
  source_sha256 'c2cf2a16646b44771a4109bb21218c8e2d952babb827796eb8a800c1f94b7422'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'cmake' => :build

  def self.build
    system 'mkdir out'
    Dir.chdir 'out' do
      system "cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} -DCMAKE_INSTALL_LIBDIR=#{CREW_DEST_LIB_PREFIX}"
      system "cmake --build . --config Release --target install"
    end
  end

  def self.install
    Dir.chdir 'out' do
      system "cmake -DCMAKE_INSTALL_PREFIX=#{CREW_DEST_PREFIX} -DCMAKE_INSTALL_LIBDIR=#{CREW_DEST_LIB_PREFIX} -P cmake_install.cmake"
    end
  end
end
