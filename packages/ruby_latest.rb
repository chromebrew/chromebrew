require 'package'

class Ruby_latest < Package
  version '2.4.0'
  source_url 'http://cache.ruby-lang.org/pub/ruby/ruby-2.4.0.tar.xz'
  source_sha1 '038804bbd0e77508dd2510b729a9f3b325489b2e'

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
