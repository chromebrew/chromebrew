require 'package'

class Libzip < Package
  description 'libzip is a C library for reading, creating, and modifying zip archives.'
  homepage 'https://libzip.org/'
  version '1.7.3'
  compatibility 'all'
  source_url 'https://libzip.org/download/libzip-1.7.3.tar.xz'
  source_sha256 'a60473ffdb7b4260c08bfa19c2ccea0438edac11193c3afbbb1f17fbcf6c6132'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libzip-1.7.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libzip-1.7.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libzip-1.7.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libzip-1.7.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a8cc96f1befee6a3d4967aa7fa41e691b1cfd564405286214fc9a12ae6ff19e6',
     armv7l: 'a8cc96f1befee6a3d4967aa7fa41e691b1cfd564405286214fc9a12ae6ff19e6',
       i686: 'aa4656edce164335ee023fb7af32b135a3ecc733c2a353550a9e325602ac79f6',
     x86_64: 'bdf0fe0f8dbaa87a70b678cc5aa3730ae7c8b4fc684ab8c499e947b999f7bb6b',
  })

  depends_on 'bz2'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'cmake',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             "-DCMAKE_INSTALL_LIBDIR=#{ARCH_LIB}",
             '-DCMAKE_BUILD_TYPE=Release',
             '..'
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
