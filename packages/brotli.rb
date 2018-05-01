require 'package'

class Brotli < Package
  description 'Brotli compression format'
  homepage 'https://github.com/google/brotli'
  version '1.0.4'
  source_url 'https://github.com/google/brotli/archive/v1.0.4.tar.gz'
  source_sha256 '2268a3dff1cc36e18549e89a51ee0cd9513908a977d56d6a1f9d4c61c2af37c3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/brotli-1.0.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/brotli-1.0.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/brotli-1.0.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/brotli-1.0.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6a66cda96e663f581bbddab3b1b57907583aa46911a94a96224de906adc4b544',
     armv7l: '6a66cda96e663f581bbddab3b1b57907583aa46911a94a96224de906adc4b544',
       i686: 'be77cf61c923ff19842c58c4979bf1c53b09eded39a02106b4d67bd164ad7049',
     x86_64: 'ab048b601fdbeb5b73f113517adb500e8c42164dcceb9450cc039b376762f546',
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
