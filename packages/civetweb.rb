require 'package'

class Civetweb < Package
  description 'Embedded C/C++ web server'
  homepage 'https://github.com/civetweb/civetweb/'
  version '1.13'
  compatibility 'all'
  source_url 'https://github.com/civetweb/civetweb/archive/v1.13.tar.gz'
  source_sha256 'a7ccc76c2f1b5f4e8d855eb328ed542f8fe3b882a6da868781799a98f4acdedc'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/civetweb-1.13-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/civetweb-1.13-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/civetweb-1.13-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/civetweb-1.13-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a9c69122c495afd89473928171d8b6528d8d1980d136cc16160733a317e21704',
     armv7l: 'a9c69122c495afd89473928171d8b6528d8d1980d136cc16160733a317e21704',
       i686: '856eeb6d5543fe03baec996f21324ad0bb14bc0a2e9c080d61cf33614697a36d',
     x86_64: 'a314284c9ea9b1f3190174645c5c13872387520dc1877a3fb7eb5397916b8bed',
  })
  
  def self.build
    Dir.mkdir "builddir"
    Dir.chdir "builddir" do
      system "cmake -G 'Ninja' #{CREW_CMAKE_OPTIONS} \
		          -DBUILD_TESTING=OFF \
		          -DBUILD_SHARED_LIBS=ON \
		          -DCIVETWEB_BUILD_TESTING=OFF \
		          -DCIVETWEB_ENABLE_LUA=OFF \
		          -DCIVETWEB_ENABLE_DUKTAPE=OFF \
		          -DCIVETWEB_ENABLE_CXX=ON \
		          -DCIVETWEB_ENABLE_SERVER_EXECUTABLE=ON \
		          -DCIVETWEB_ENABLE_SSL=ON .."
      system "ninja"
    end
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.check
    system "ninja -C builddir test"
  end
end
