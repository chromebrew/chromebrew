require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.haxx.se/'
  version '7.72.0-1'
  compatibility 'all'
  source_url 'https://curl.haxx.se/download/curl-7.72.0.tar.xz'
  source_sha256 '0ded0808c4d85f2ee0db86980ae610cc9d165e9ca9da466196cc73c346513713'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.72.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.72.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.72.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.72.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bf7579c54c6e06479f615d1abf87adf89fc39f3d2c404e2ab2cb95070ace6098',
     armv7l: 'bf7579c54c6e06479f615d1abf87adf89fc39f3d2c404e2ab2cb95070ace6098',
       i686: '6fead78266081c9f909b0b5f5f58b0ad70c4acfc0d1fe691c9556b718aefe5f9',
     x86_64: '99097864dbb9b36941387cde22ccfff3ce6e3f5e8f79f7975dfedb9c875f6a7e',
  })

  depends_on 'groff' => :build
  depends_on 'brotli'
  depends_on 'c_ares'
  depends_on 'libiconv'
  depends_on 'libidn2'
  depends_on 'libmbedtls'
  depends_on 'libmetalink'
  depends_on 'libnghttp2'
  depends_on 'libtirpc'
  depends_on 'libunbound'
  depends_on 'openldap'
  depends_on 'rtmpdump'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'cmake',
             "-DCMAKE_INSTALL_MANDIR=#{CREW_MAN_PREFIX}",
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             "-DCMAKE_INSTALL_LIBDIR=#{ARCH_LIB}",
             '-DCMAKE_BUILD_TYPE=Release',
             '-DCMAKE_USE_OPENLDAP=ON',
             '-DCMAKE_USE_MBEDTLS=ON',
             '-DCURL_BROTLI=ON',
             '-DUSE_NGHTTP2=ON',
             '-ENABLE_ARES=ON',
             '..'
      system 'make'
    end
  end

  def self.check
    Dir.chdir 'build' do
      #system 'ctest'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
