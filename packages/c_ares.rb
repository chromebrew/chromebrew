require 'package'

class C_ares < Package
  description 'c-ares is a C library for asynchronous DNS requests (including name resolves).'
  homepage 'https://c-ares.haxx.se/'
  version '1.13.0'
  source_url 'https://c-ares.haxx.se/download/c-ares-1.13.0.tar.gz'
  source_sha256 '03f708f1b14a26ab26c38abd51137640cb444d3ec72380b21b20f1a8d2861da7'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/c_ares-1.13.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/c_ares-1.13.0-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/c_ares-1.13.0-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/c_ares-1.13.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '750a615e4facc29c6bd14287bdd33b898e41ffaec0d58e572bd6b5f0091d7235',
     armv7l: '750a615e4facc29c6bd14287bdd33b898e41ffaec0d58e572bd6b5f0091d7235',
       i686: '33846c33b585cedb0f79614f0a7605417027317e1ba11b9817bd8399b310eea2',
     x86_64: '2bbe81d4a4ca4c5ed396625f7b93ba876144fedec201d3f2093eecf718635c1e',
  })

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
