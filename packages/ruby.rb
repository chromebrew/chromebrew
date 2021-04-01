require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '3.0.0-2'
  license 'Ruby-BSD and BSD-2'
  compatibility 'all'
  source_url 'https://cache.ruby-lang.org/pub/ruby/3.0/ruby-3.0.0.tar.gz'
  source_sha256 'a13ed141a1c18eb967aac1e33f4d6ad5f21be1ac543c344e0d6feeee54af8e28'

  depends_on 'ca_certificates'
  depends_on 'ncurses'
  depends_on 'libyaml' # This is needed to install gems
  # at run-time, system's gmp, openssl, readline and zlibpkg are possible to use

  def self.build
    # The download from ruby-lang.org doesn't need autoconf run,
    # but the download from github does.
    # system 'autoreconf -fiv'
    system "env CFLAGS='-ltinfow -flto=auto' CXXFLAGS='-flto=auto' \
    LDFLAGS='-flto=auto' \
    optflags='-flto=auto' \
    ./configure #{CREW_OPTIONS} \
    --enable-shared \
    --disable-fortify-source"
    system 'make'
  end

  def self.check
    system "TMPDIR=#{CREW_PREFIX}/tmp make check || true"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    system 'gem update --silent -N --system'
  end
end
