require 'package'

class Tidy < Package
  description 'The granddaddy of HTML tools, with support for modern standards'
  homepage 'http://www.html-tidy.org/'
  version '5.6.0'
  source_url 'https://github.com/htacg/tidy-html5/archive/5.6.0.tar.gz'
  source_sha256 '08a63bba3d9e7618d1570b4ecd6a7daa83c8e18a41c82455b6308bc11fe34958'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "cmake . -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "LIBDIR=#{CREW_LIB_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
