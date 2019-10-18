require 'package'

class Brotli < Package
  description 'Brotli compression format'
  homepage 'https://github.com/google/brotli'
  version '1.0.7'
  source_url 'https://github.com/google/brotli/archive/v1.0.7.tar.gz'
  source_sha256 '4c61bfb0faca87219ea587326c467b95acb25555b53d1a421ffa3c8a9296ee2c'

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
