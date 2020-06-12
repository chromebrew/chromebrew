require 'package'

class Lapack < Package
  description 'Lapack is a linear algebra package.'
  homepage 'https://www.netlib.org/lapack/'
  version '3.8.0-1'
  compatibility 'all'
  source_url 'https://www.netlib.org/lapack/lapack-3.8.0.tar.gz'
  source_sha256 'deb22cc4a6120bff72621155a9917f485f96ef8319ac074a7afbc68aab88bcf6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/lapack-3.8.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/lapack-3.8.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/lapack-3.8.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/lapack-3.8.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f93b9afdd088faa48b11735b7467a2056f13efc98d0edc158166364f1edd795d',
     armv7l: 'f93b9afdd088faa48b11735b7467a2056f13efc98d0edc158166364f1edd795d',
       i686: '3f3d266856c00034b1f3a1efad00a4a8d838ecbc3682cc7a3788fbb209ff0da7',
     x86_64: '45aec7ef9a9c37e098be7fd80b88c580bef29181b398e6e4c8d15cee9ddf7456',
  })

  depends_on 'python27'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'cmake',
             '-DCMAKE_BUILD_TYPE=Release',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             "-DCMAKE_INSTALL_LIBDIR=#{CREW_LIB_PREFIX}",
             '-DBUILD_SHARED_LIBS=ON',
             '..'
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
