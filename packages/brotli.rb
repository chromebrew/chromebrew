require 'package'

class Brotli < Package
  description 'Brotli compression format'
  homepage 'https://github.com/google/brotli'
  version '1.0.8'
  compatibility 'all'
  source_url 'https://github.com/google/brotli/archive/v1.0.8.tar.gz'
  source_sha256 'a0bfaf49d8d35262ef1d1e617486b061f47c634721c345051bf8d9fb806f3bb9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/brotli-1.0.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/brotli-1.0.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/brotli-1.0.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/brotli-1.0.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '636a5bb46059311e280f1828aa032e2d2bad83905b124549159b73e279856688',
     armv7l: '636a5bb46059311e280f1828aa032e2d2bad83905b124549159b73e279856688',
       i686: 'c16396d2d9a4a000b360fd6f096e4f0053abafb7bf1f8c84766527ea7a4b074f',
     x86_64: '921fc1be57c195176d500f82bf96a52566824e62036c329ced629a0177c7c9d1',
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
