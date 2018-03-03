require 'package'

class Weechat < Package
  description "WeeChat is a fast, light and extensible chat client."
  homepage 'http://www.weechat.org/'
  version '2.0.1'
  source_url 'https://weechat.org/files/src/weechat-2.0.1.tar.xz'
  source_sha256 '6943582eabbd8a6fb6dca860a86f896492cae5fceacaa396dbc9eeaa722305d1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/weechat-2.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/weechat-2.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/weechat-2.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/weechat-2.0.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e1d444bca78dd74a8913d5c1affbb00c698f4ed53ba1cb73426beb7f4710d074',
     armv7l: 'e1d444bca78dd74a8913d5c1affbb00c698f4ed53ba1cb73426beb7f4710d074',
       i686: '75f092da7af5d3eddca50da63fba349148d4a9359e5f049a6c455f334915b2f1',
     x86_64: '6cb6feeadf075aa7c5bf09b86c110d378715f5caf3eae320454305ae11268b2d',
  })

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
