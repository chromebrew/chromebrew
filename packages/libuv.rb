require 'package'

class Libuv < Package
  description 'libuv is a multi-platform support library with a focus on asynchronous I/O.'
  homepage 'http://libuv.org/'
  version '1.33.1'
  compatibility 'all'
  source_url 'https://dist.libuv.org/dist/v1.33.1/libuv-v1.33.1.tar.gz'
  source_sha256 'b4b5dc15103f7bbfecb81a0a9575841fdb7217b9f709634be8118972c1c8ce27'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libuv-1.33.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libuv-1.33.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libuv-1.33.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libuv-1.33.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a03bac49ca23048badd32c4bcdebd9a1acb948e87c1e8a44011214ebbd946c07',
     armv7l: 'a03bac49ca23048badd32c4bcdebd9a1acb948e87c1e8a44011214ebbd946c07',
       i686: '44c2c3146a1123a82588183f6291d9365e10a9497b7854a7e8e89d564c875052',
     x86_64: '679bc3ae5d4ff33b335840fff43087fc2144619eeb678f5c047689c74840faf8',
  })

  def self.build
    system './autogen.sh'
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
