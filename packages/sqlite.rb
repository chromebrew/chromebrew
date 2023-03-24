require 'package'

class Sqlite < Package
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'http://www.sqlite.org/'
  version '3.41.2'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://www.sqlite.org/2023/sqlite-autoconf-3410200.tar.gz'
  source_sha256 'e98c100dd1da4e30fa460761dab7c0b91a50b785e167f8c57acc46514fae9499'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.41.2_armv7l/sqlite-3.41.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.41.2_armv7l/sqlite-3.41.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.41.2_i686/sqlite-3.41.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.41.2_x86_64/sqlite-3.41.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '22cc6dde4a403dc5f3a88d8fbb1c44cad5758e6cc769c38865a73ff524951cae',
     armv7l: '22cc6dde4a403dc5f3a88d8fbb1c44cad5758e6cc769c38865a73ff524951cae',
       i686: 'd786033d3f0330354f858884f204466c1b935cda1d1b842594de8e481f939ea5',
     x86_64: 'b59ce4583e9d641ab700e8511aa954ad87f6b1c7393f6cb33adc1d8231498412'
  })

  depends_on 'glibc' # R
  depends_on 'libedit' # R
  depends_on 'readline' => :build
  depends_on 'zlibpkg' # R
  depends_on 'ncurses' # R

  def self.build
    system "./configure #{CREW_OPTIONS} \
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
