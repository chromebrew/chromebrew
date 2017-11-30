require 'package'

class Ruby_latest < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '2.4.2'
  source_url 'http://cache.ruby-lang.org/pub/ruby/ruby-2.4.2.tar.xz'
  source_sha256 '748a8980d30141bd1a4124e11745bb105b436fb1890826e0d2b9ea31af27f735'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ruby_latest-2.4.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ruby_latest-2.4.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ruby_latest-2.4.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ruby_latest-2.4.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e21f4c1301c534048773353d5b5b55d1b70a16c42bc6a8263ea8fadd50ef6aee',
     armv7l: 'e21f4c1301c534048773353d5b5b55d1b70a16c42bc6a8263ea8fadd50ef6aee',
       i686: '4a5b77ed24bd03a3265df547b19baa5c3b5d998aeebb7f07b694d0a824d3ed54',
     x86_64: '3f2e8a72d34aa25010e4cbf6cc1534a622aef1550e7cbdb1590ebeb4e8af7a3f',
  })

  depends_on 'readline'
  depends_on 'zlibpkg'
  depends_on 'openssl'

  def self.build
    system "CC='gcc' ./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
