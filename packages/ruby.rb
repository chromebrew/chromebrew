require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '2.7.2'
  compatibility 'all'
  source_url 'https://cache.ruby-lang.org/pub/ruby/2.7/ruby-2.7.2.tar.xz'
  source_sha256 '1b95ab193cc8f5b5e59d2686cb3d5dcf1ddf2a86cb6950e0b4bdaae5040ec0d6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-2.7.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-2.7.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-2.7.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-2.7.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a435e6bf7965e1a82e8842e5ea66bdd670ec9b627d785bd720d3d2652fc89f6d',
     armv7l: 'a435e6bf7965e1a82e8842e5ea66bdd670ec9b627d785bd720d3d2652fc89f6d',
       i686: '81865864d3ba93b6cbd5dc8e1b6cb51bd2ebe854f6c01e282c1b73f379fb7caf',
     x86_64: '658808516b7a2e58f8102fd131e765aaa79f2a7c906d0330b7e883fbdc12d1a9',
  })

  depends_on 'readline'
  depends_on 'ncurses'
  depends_on 'zlibpkg' => :build
  depends_on 'libressl' => :build
  # at run-time, system's gmp, openssl, readline and zlibpkg are possible to use

  def self.build
    system "./configure #{CREW_OPTIONS} --enable-shared"
    system 'make'
  end

  def self.check
    #system "TMPDIR=#{CREW_PREFIX}/tmp make check"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
