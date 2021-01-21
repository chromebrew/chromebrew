require 'package'

class Libssh < Package
  description 'libssh is a multiplatform C library implementing the SSHv2 and SSHv1 protocol on client and server side.'
  homepage 'https://www.libssh.org/'
  version '0.9.5'
  compatibility 'all'
  source_url 'https://www.libssh.org/files/0.9/libssh-0.9.5.tar.xz'
  source_sha256 'acffef2da98e761fc1fd9c4fddde0f3af60ab44c4f5af05cd1b2d60a3fa08718'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libssh-0.9.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libssh-0.9.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libssh-0.9.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libssh-0.9.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '45e7c8962944c4ac002e9cc979dbd2cf489bb83c7a655c7d06765eebb92fee14',
     armv7l: '45e7c8962944c4ac002e9cc979dbd2cf489bb83c7a655c7d06765eebb92fee14',
       i686: '84bb42a662fa7c7c4e7e74e014f9fa489c48150ec24c89da7b44241b4da7dae8',
     x86_64: '1e288d85f122cf5fbce82464aa665bf453fdb70eb306eb891f39a4ef61b4de43',
  })

  depends_on 'libgcrypt'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "cmake \
             #{CREW_CMAKE_OPTIONS} \
             -DCMAKE_C_FLAGS='-fstack-protector-strong' \
             -DWITH_GCRYPT=ON \
             .."
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
