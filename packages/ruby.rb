require 'package'

class Ruby < Package
  description 'Ruby is a dynamic, open source programming language with a focus on simplicity and productivity.'
  homepage 'https://www.ruby-lang.org/en/'
  version '3.0.0'
  compatibility 'all'
  source_url 'https://cache.ruby-lang.org/pub/ruby/3.0/ruby-3.0.0.tar.gz'
  source_sha256 'a13ed141a1c18eb967aac1e33f4d6ad5f21be1ac543c344e0d6feeee54af8e28'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-3.0.0-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-3.0.0-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-3.0.0-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ruby-3.0.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '81509c5d3585f1a0c3c7d616d9f9a0d0192c6e3276c3ddea23c3905e78e56bfc',
      armv7l: '81509c5d3585f1a0c3c7d616d9f9a0d0192c6e3276c3ddea23c3905e78e56bfc',
        i686: '6a624ec30b5b6f32a842ec9f686278ce239d729f9736bf1b5d74ac08a716e0ef',
      x86_64: '64ab9f4df6ab0185f7f74a0deb6a809d5ba910128f730522f21079062985108f',
  })

  depends_on 'readline'
  depends_on 'ncurses'
  depends_on 'zlibpkg' => :build
  depends_on 'libressl' => :build
  # at run-time, system's gmp, openssl, readline and zlibpkg are possible to use

  def self.build
    # The download from ruby-lang.org doesn't need autoconf run,
    # but the download from github does.
    #system "autoconf"
    system "CFLAGS='-ltinfo -flto' \
    CXXFLAGS='-flto' \
    optflags='-flto' \
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
end
