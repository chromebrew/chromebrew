require 'package'

class Sqlite < Package
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'http://www.sqlite.org/'
  version '3.33.0'
  compatibility 'all'
  source_url 'https://sqlite.org/2020/sqlite-autoconf-3330000.tar.gz'
  source_sha256 '106a2c48c7f75a298a7557bcc0d5f4f454e5b43811cc738b7ca294d6956bbb15'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sqlite-3.33.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sqlite-3.33.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sqlite-3.33.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sqlite-3.33.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '27a1d3b134071c152133e377a4be1900a93a22a9e9c9ca57fdb1532f09c1f142',
     armv7l: '27a1d3b134071c152133e377a4be1900a93a22a9e9c9ca57fdb1532f09c1f142',
       i686: '6a4c154e2c863c487139dfe3890982634ec4e8ac8572fac887faddc452fd76d6',
     x86_64: 'a508152321c6a8175d48c9203a6aedc24d279fc1bd5e53ed7bcfb8816b70bbdc',
  })

  depends_on 'libedit'
  depends_on 'readline'
  depends_on 'zlibpkg'

  def self.build
    system "./configure #{CREW_OPTIONS} \
      --disable-static \
      --enable-shared \
      --enable-editline \
      --enable-readline \
      --enable-fts5 \
      --enable-json1 \
      --enable-session \
      --with-pic"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
