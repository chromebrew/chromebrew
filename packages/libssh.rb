require 'package'

class Libssh < Package
  description 'libssh is a multiplatform C library implementing the SSHv2 and SSHv1 protocol on client and server side.'
  homepage 'https://www.libssh.org/'
  version '0.8.1'
  compatibility 'all'
  source_url 'https://www.libssh.org/files/0.8/libssh-0.8.1.tar.xz'
  source_sha256 'd17f1267b4a5e46c0fbe66d39a3e702b8cefe788928f2eb6e339a18bb00b1924'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libssh-0.8.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libssh-0.8.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libssh-0.8.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libssh-0.8.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0928c31849b027b3188b765c4ee7434cad046523cf4a54355e125421baaf64c5',
     armv7l: '0928c31849b027b3188b765c4ee7434cad046523cf4a54355e125421baaf64c5',
       i686: 'ee40bfa70d6b0fd644ab58f081dd3c82f29ca0f28586698eed55c79d79656c47',
     x86_64: '8cca9b0403091a838e65b2306cb5bb3b8ed549502d7e54c442af0fac1a3fc671',
  })

  depends_on 'libgcrypt'

  def self.build
    FileUtils.mkdir 'build'
    Dir.chdir 'build' do
      system "cmake \
             -DWITH_GCRYPT=ON \
             -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} \
             -DLIB_INSTALL_DIR=#{CREW_LIB_PREFIX} \
             -DCMAKE_BUILD_TYPE=Release .."
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
