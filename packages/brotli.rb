require 'package'

class Brotli < Package
  description 'Brotli compression format'
  homepage 'https://github.com/google/brotli'
  version '1.0.7'
  compatibility 'all'
  source_url 'https://github.com/google/brotli/archive/v1.0.7.tar.gz'
  source_sha256 '4c61bfb0faca87219ea587326c467b95acb25555b53d1a421ffa3c8a9296ee2c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/brotli-1.0.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/brotli-1.0.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/brotli-1.0.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/brotli-1.0.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '43431c301ab6830cf2a79c6d4fb6e7ea931259bab62166f61b1fb9ba7ad00502',
     armv7l: '43431c301ab6830cf2a79c6d4fb6e7ea931259bab62166f61b1fb9ba7ad00502',
       i686: '6f1447ea8c2583762e63fda4a410b0c27a53706ab7cd0c5d7bec8613bb0437ec',
     x86_64: 'e4e0eea55f7d0adf9fb619e9b14b91ed5d906cd3d8b7f441d33357c662b4f6f7',
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
