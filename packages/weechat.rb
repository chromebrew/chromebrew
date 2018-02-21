require 'package'

class Weechat < Package
  description "WeeChat is a fast, light and extensible chat client."
  homepage 'http://www.weechat.org/'
  version '2.0.1'
  source_url 'https://weechat.org/files/src/weechat-2.0.1.tar.xz'
  source_sha256 '6943582eabbd8a6fb6dca860a86f896492cae5fceacaa396dbc9eeaa722305d1'

  depends_on 'curl'
  depends_on 'gnutls'
  depends_on 'libgcrypt'
  depends_on 'aspell' => :build
  depends_on 'cmake' => :build
  depends_on 'git' => :build
  depends_on 'lua' => :build
  depends_on 'perl' => :build
  depends_on 'pkgconfig' => :build
  depends_on 'python27' => :build
  depends_on 'ruby' => :build
  depends_on 'tcl' => :build

  def self.build
    system "cmake",
    		   "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
    	           "-DCMAKE_BUILD_TYPE=Release",
	 	   "-DENABLE_MAN=ON",
		   "-DPYTHON_EXECUTABLE=#{CREW_PREFIX}/bin/python2"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
