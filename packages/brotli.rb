require 'package'

class Brotli < Package
  description 'Brotli compression format'
  homepage 'https://github.com/google/brotli'
  version '1.0.8'
  compatibility 'all'
  source_url 'https://github.com/google/brotli/archive/v1.0.8.tar.gz'
  source_sha256 'a0bfaf49d8d35262ef1d1e617486b061f47c634721c345051bf8d9fb806f3bb9'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    Dir.mkdir 'out'
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
