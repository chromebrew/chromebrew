require 'package'

class Civetweb < Package
  description 'Embedded C/C++ web server'
  homepage 'https://github.com/civetweb/civetweb/'
  version '0.12.1'
  compatibility 'all'
  source_url 'https://github.com/civetweb/civetweb/archive/v1.13.tar.gz'
  source_sha256 'a7ccc76c2f1b5f4e8d855eb328ed542f8fe3b882a6da868781799a98f4acdedc'

  depends_on 'openssl'
  
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
