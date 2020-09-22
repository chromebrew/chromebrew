require 'package'

class Libmbedtls < Package
  description 'An open source, portable, easy to use, readable and flexible SSL library'
  homepage 'https://tls.mbed.org/'
  version '2.16.8'
  compatibility 'all'
  source_url 'https://github.com/ARMmbed/mbedtls/archive/v2.16.8.tar.gz'
  source_sha256 'fe9e3b15c3375943bdfebbbb20dd6b4f1147b3b5d926248bd835d73247407430'

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
