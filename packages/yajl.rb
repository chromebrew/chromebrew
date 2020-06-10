require 'package'

class Yajl < Package
  description 'A fast streaming JSON parsing library in C.'
  homepage 'http://lloyd.github.io/yajl/'
  version '2.1.0-1'
  compatibility 'all'
  source_url 'https://github.com/lloyd/yajl/archive/2.1.0.tar.gz'
  source_sha256 '3fb73364a5a30efe615046d07e6db9d09fd2b41c763c5f7d3bfb121cd5c5ac5a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/yajl-2.1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/yajl-2.1.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/yajl-2.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/yajl-2.1.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'efdb7b820b6c7cc02e5d443db956eefd74c537e38b0cba19adf81ded4f10ff9a',
     armv7l: 'efdb7b820b6c7cc02e5d443db956eefd74c537e38b0cba19adf81ded4f10ff9a',
       i686: 'd5f49f959e0de265a0f1ffda1e0000850753b4247cdc3b9b5a7256c6560ab166',
     x86_64: 'c16902c4da5b807783a9002566328c1e6545c0f5eb4d673b5fbb0d028bdb0513',
  })

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "cmake .. -DCMAKE_C_FLAGS=' -fPIC' -DPREFIX=#{CREW_PREFIX} -DCMAKE_INSTALL_LIBDIR=#{CREW_DEST_LIB_PREFIX}"
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
