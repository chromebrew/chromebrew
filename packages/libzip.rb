require 'package'

class Libzip < Package
  description 'libzip is a C library for reading, creating, and modifying zip archives.'
  homepage 'https://libzip.org/'
  version '1.5.1'
  compatibility 'all'
  source_url 'https://libzip.org/download/libzip-1.5.1.tar.xz'
  source_sha256 '04ea35b6956c7b3453f1ed3f3fe40e3ddae1f43931089124579e8384e79ed372'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libzip-1.5.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libzip-1.5.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libzip-1.5.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libzip-1.5.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd219497c9fb7451c26c93dd9379808fbbd936317e765be63beafb8d91db2a84d',
     armv7l: 'd219497c9fb7451c26c93dd9379808fbbd936317e765be63beafb8d91db2a84d',
       i686: 'd286172ecf333bed71e0bd1c7713cbbefb5a5434e2592ee5e67cd881bccb5784',
     x86_64: '4d1fa9fad684b7e4aa92885e247e963ac7ad1a1c85fd7a35cec728491a2e72cc',
  })

  depends_on 'bz2'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'cmake',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             "-DCMAKE_INSTALL_LIBDIR=#{ARCH_LIB}",
             '-DCMAKE_BUILD_TYPE=Release ..'
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end

  def self.check
    Dir.chdir 'build' do
      system "make", "check"
    end
  end
end
