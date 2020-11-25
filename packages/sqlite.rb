require 'package'

class Sqlite < Package
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'http://www.sqlite.org/'
  version '3.33.0'
  compatibility 'all'
  source_url 'https://sqlite.org/2020/sqlite-autoconf-3330000.tar.gz'
  source_sha256 '106a2c48c7f75a298a7557bcc0d5f4f454e5b43811cc738b7ca294d6956bbb15'

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
