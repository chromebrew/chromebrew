require 'package'

class Libmbedtls < Package
  description 'An open source, portable, easy to use, readable and flexible SSL library'
  homepage 'https://tls.mbed.org/'
  version '2.16.8'
  compatibility 'all'
  source_url 'https://github.com/ARMmbed/mbedtls/archive/v2.16.8.tar.gz'
  source_sha256 'fe9e3b15c3375943bdfebbbb20dd6b4f1147b3b5d926248bd835d73247407430'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libmbedtls-2.16.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libmbedtls-2.16.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libmbedtls-2.16.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libmbedtls-2.16.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fa1207538c87a278987bd49aa789d9a064745eb17af6e0bca986cab290f7c8e4',
     armv7l: 'fa1207538c87a278987bd49aa789d9a064745eb17af6e0bca986cab290f7c8e4',
       i686: '82f4fe07be9599125bbce078e3ff8a5c3f2c96691270abc60cf97fed79879e45',
     x86_64: '58e98d4edf8ff733228ff2499e7faf33bfc1d90bc6c834e8b1b78b7c369b85f1',
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
