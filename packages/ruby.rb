require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '2.4.1'
  source_url 'https://cache.ruby-lang.org/pub/ruby/2.4/ruby-2.4.1.tar.xz'
  source_sha1 'eb3e25346431214379e3b92c6f6b6e02f7b2503f'

  depends_on 'readline'
  depends_on 'ncurses'
  depends_on 'zlibpkg' => :build
  depends_on 'openssl' => :build
  # at run-time, system's gmp, openssl, readline and zlibpkg are possible to use

  def self.build
    system "CC='gcc' ./configure"
    system "make"
    system "find . -name '*.so' | xargs strip -S"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "strip #{CREW_DEST_DIR}/usr/local/bin/ruby"
  end

  def self.check
    system "TMPDIR=/usr/local/tmp make check"
  end
end
