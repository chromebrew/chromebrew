require 'package'

class Libzip < Package
  description 'libzip is a C library for reading, creating, and modifying zip archives.'
  homepage 'https://libzip.org/'
  version '1.7.3'
  compatibility 'all'
  source_url 'https://libzip.org/download/libzip-1.7.3.tar.xz'
  source_sha256 'a60473ffdb7b4260c08bfa19c2ccea0438edac11193c3afbbb1f17fbcf6c6132'

  binary_url ({
  })
  binary_sha256 ({
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
