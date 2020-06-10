require 'package'

class Libmbedtls < Package
  description 'An open source, portable, easy to use, readable and flexible SSL library'
  homepage 'https://tls.mbed.org/'
  version '2.16.5'
  compatibility 'all'
  source_url 'https://tls.mbed.org/download/mbedtls-2.16.5-apache.tgz'
  source_sha256 '65b4c6cec83e048fd1c675e9a29a394ea30ad0371d37b5742453f74084e7b04d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libmbedtls-2.16.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libmbedtls-2.16.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libmbedtls-2.16.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libmbedtls-2.16.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e110f3d42b6228c10790996e834ff21f1fe99cbc93d7869fc3d9e5dc058a6f64',
     armv7l: 'e110f3d42b6228c10790996e834ff21f1fe99cbc93d7869fc3d9e5dc058a6f64',
       i686: 'fb8257eb9eaa4fbaf25ae518464013b0b6c0fc4ebd02c25ff657df64df517b6a',
     x86_64: '28de88799e5aa56d9ae16c8df6e22b60607d58f1191a3a37ff14270fb3c88e6b',
  })

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'cmake',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             '-DUSE_SHARED_MBEDTLS_LIBRARY=ON',
             '-DCMAKE_BUILD_TYPE=Release',
             '-DENABLE_ZLIB_SUPPORT=ON',
             '..'
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
      FileUtils.mv "#{CREW_DEST_PREFIX}/lib", "#{CREW_DEST_LIB_PREFIX}" if ARCH == 'x86_64'
    end
  end
end
