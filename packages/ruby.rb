require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '3.0.2'
  license 'Ruby-BSD and BSD-2'
  compatibility 'all'
  source_url 'https://cache.ruby-lang.org/pub/ruby/3.0/ruby-3.0.2.tar.gz'
  source_sha256 '5085dee0ad9f06996a8acec7ebea4a8735e6fac22f22e2d98c3f2bc3bef7e6f1'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.0.2_armv7l/ruby-3.0.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.0.2_armv7l/ruby-3.0.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.0.2_i686/ruby-3.0.2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby/3.0.2_x86_64/ruby-3.0.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'ad593ad2768a370594cc8353127f8754b67855a8f89606ed02c5517d3c6c0d8c',
     armv7l: 'ad593ad2768a370594cc8353127f8754b67855a8f89606ed02c5517d3c6c0d8c',
       i686: 'e484cc77a18a0e85ae7e30d0ad3c9fe11da044ddffd3ebbcc30a3468ceb850ff',
     x86_64: 'a6f630ab4a14e584fcabb2c66c3005d0db01d856f25bb6ced527b7e93d9e0762'
  })

  depends_on 'ca_certificates'
  depends_on 'libyaml' # This is needed to install gems
  # at run-time, system's gmp, openssl, readline and zlibpkg are possible to use

  def self.build
    # The download from ruby-lang.org doesn't need autoconf run,
    # but the download from github does.
    system '[ -x configure ] || autoreconf -fiv'
    system "env RUBY_CONF_ENV='stack_protector=no' \
    CFLAGS='-ltinfow -flto=auto' CXXFLAGS='-flto=auto' \
    LDFLAGS='-flto=auto' \
    optflags='-flto=auto' \
    ./configure #{CREW_OPTIONS} \
    --enable-shared \
    --disable-fortify-source"
    system 'make'
  end

  # def self.check
  #  system 'make check || true'
  # end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    system 'gem update --silent -N --system'
  end
end
