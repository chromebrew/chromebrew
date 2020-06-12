require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '2.7.1'
  compatibility 'all'
  source_url 'https://cache.ruby-lang.org/pub/ruby/2.7/ruby-2.7.1.tar.xz'
  source_sha256 'b224f9844646cc92765df8288a46838511c1cec5b550d8874bd4686a904fcee7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-2.7.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-2.7.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-2.7.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-2.7.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8808b9bc9b55206781ea706008f405a12083af15839ff69d96434674004baee8',
     armv7l: '8808b9bc9b55206781ea706008f405a12083af15839ff69d96434674004baee8',
       i686: '5544e722fb76733df5fb3734db4bed818668b11fbb01f9484b1c85f78fd442c6',
     x86_64: 'bcce410dc64861dcb57c7e72e5eedc3df79ca94d6e0d0ee32e0d14d1fd3712c0',
  })

  depends_on 'readline'
  depends_on 'ncurses'
  depends_on 'zlibpkg' => :build
  depends_on 'openssl' => :build
  # at run-time, system's gmp, openssl, readline and zlibpkg are possible to use

  def self.build
    system "./configure #{CREW_OPTIONS} --enable-shared"
    system 'make'
  end

  def self.check
    system "TMPDIR=#{CREW_PREFIX}/tmp make check"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
