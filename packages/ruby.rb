require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '2.7.2-1'
  compatibility 'all'
  source_url 'https://cache.ruby-lang.org/pub/ruby/2.7/ruby-2.7.2.tar.xz'
  source_sha256 '1b95ab193cc8f5b5e59d2686cb3d5dcf1ddf2a86cb6950e0b4bdaae5040ec0d6'


  depends_on 'readline'
  depends_on 'ncurses'
  depends_on 'zlibpkg' => :build
  depends_on 'libressl' => :build
  # at run-time, system's gmp, openssl, readline and zlibpkg are possible to use

  def self.build
    ENV['CFLAGS'] = '-ltinfo -fstack-protector-all'
    system "./configure #{CREW_OPTIONS} \
    --enable-shared \
    --disable-fortify-source \
    --disable-install-doc \
    --disable-install-rdoc \
    --disable-install-capi"
    system 'make'
  end

  def self.check
    #system "TMPDIR=#{CREW_PREFIX}/tmp make check"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
