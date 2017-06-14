require 'package'

class Ruby_latest < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '2.4.0'
  source_url 'http://cache.ruby-lang.org/pub/ruby/ruby-2.4.0.tar.xz'
  source_sha1 '038804bbd0e77508dd2510b729a9f3b325489b2e'

  depends_on 'readline'
  depends_on 'zlibpkg'
  depends_on 'openssl'

  def self.build
    system "CC='gcc' ./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
