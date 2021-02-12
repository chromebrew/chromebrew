require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '3.0.0-2'
  compatibility 'all'
  source_url 'https://cache.ruby-lang.org/pub/ruby/3.0/ruby-3.0.0.tar.gz'
  source_sha256 'a13ed141a1c18eb967aac1e33f4d6ad5f21be1ac543c344e0d6feeee54af8e28'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-3.0.0-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-3.0.0-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-3.0.0-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-3.0.0-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '6e2d40ea5d1bafbe0b79e1a0ae644911f33a9ceb94716d3e4c05d91884850b28',
     armv7l: '6e2d40ea5d1bafbe0b79e1a0ae644911f33a9ceb94716d3e4c05d91884850b28',
       i686: '44422c2fbe7c1d4d8d0088d12c1691d33de19fbe10a1461d9b3ce8cf1e2e7e1e',
     x86_64: '20d4d18d1a184a088abb5547bc94e7f6189229565157bb35c5691cf0f1264f9f'
  })

  depends_on 'ca_certificates'
  depends_on 'libyaml' # This is needed to install gems
  # at run-time, system's gmp, openssl, readline and zlibpkg are possible to use

  def self.build
    # The download from ruby-lang.org doesn't need autoconf run,
    # but the download from github does.
    # system 'autoreconf -fiv'
    system "env CFLAGS='-ltinfo -flto=auto' CXXFLAGS='-flto=auto' \
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
