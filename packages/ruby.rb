require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '2.4.1'
  source_url 'https://cache.ruby-lang.org/pub/ruby/2.4/ruby-2.4.1.tar.xz'
  source_sha256 '4fc8a9992de3e90191de369270ea4b6c1b171b7941743614cc50822ddc1fe654'

  depends_on 'readline'
  depends_on 'ncurses'
  depends_on 'zlibpkg' => :build
  depends_on 'openssl' => :build
  # at run-time, system's gmp, openssl, readline and zlibpkg are possible to use

  def self.build
    system "CC='gcc' ./configure --libdir=#{CREW_LIB_PREFIX} --enable-shared"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "TMPDIR=/usr/local/tmp make check"
  end
end
