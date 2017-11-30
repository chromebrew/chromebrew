require 'package'

class Brotli < Package
  description 'Brotli compression format '
  homepage 'https://github.com/google/brotli'
  version '1.0.1'
  source_url 'https://github.com/google/brotli/archive/v1.0.1.tar.gz'
  source_sha256 '6870f9c2c63ef58d7da36e5212a3e1358427572f6ac5a8b5a73a815cf3e0c4a6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/brotli-1.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/brotli-1.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/brotli-1.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/brotli-1.0.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b2aad6d61093baf6b7199aafdddd616a9e9fba0d4ccfd63424d7ee761058d036',
     armv7l: 'b2aad6d61093baf6b7199aafdddd616a9e9fba0d4ccfd63424d7ee761058d036',
       i686: 'b1263bd17bdfa73f7707620250eba1a53e394ac8477aff5791e6300efff8bd32',
     x86_64: 'a788b15e063de1e6bf4b11c821bd0d2f8839fb17700033672bf742f07e80c92e',
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
    #system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    Dir.chdir 'out' do
      system "cmake -DCMAKE_INSTALL_PREFIX=#{CREW_DEST_PREFIX} -DCMAKE_INSTALL_LIBDIR=#{CREW_DEST_LIB_PREFIX} -P cmake_install.cmake"
    end
  end
end
