require 'package'

class C_ares < Package
  description 'c-ares is a C library for asynchronous DNS requests (including name resolves).'
  homepage 'https://c-ares.haxx.se/'
  version '1.14.0'
  source_url 'https://c-ares.haxx.se/download/c-ares-1.14.0.tar.gz'
  source_sha256 '45d3c1fd29263ceec2afc8ff9cd06d5f8f889636eb4e80ce3cc7f0eaf7aadc6e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/c_ares-1.14.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/c_ares-1.14.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/c_ares-1.14.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/c_ares-1.14.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7d03bd0a5b53a42f2c3e32f9a4dfe567f9de6b1214cd0fcfe90e35f2b93472ce',
     armv7l: '7d03bd0a5b53a42f2c3e32f9a4dfe567f9de6b1214cd0fcfe90e35f2b93472ce',
       i686: 'eecab4942b826db4a026b5a18bd910789cdf1558da9b8f57bf0ffff8c0d562cf',
     x86_64: '0cc2f4240991705665aa3c6cb4ca196e54808c441e6acac983c9c278dbaae2f8',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
