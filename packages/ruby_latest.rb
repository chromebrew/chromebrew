require 'package'

class Ruby_latest < Package
  version '2.3.3'
  source_url 'http://cache.ruby-lang.org/pub/ruby/2.3/ruby-2.3.3.tar.xz'
  source_sha1 'f2318460606d410e80dd5c82862a93e5736534de'

  depends_on 'readline'
  depends_on 'zlibpkg'

  def self.build
    system "CC='gcc' ./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
