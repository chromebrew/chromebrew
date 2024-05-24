require 'buildsystems/autotools'

class Sqlite < Autotools
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'http://www.sqlite.org/'
  version '3.46.0'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://www.sqlite.org/2024/sqlite-autoconf-3460000.tar.gz'
  source_sha256 '6f8e6a7b335273748816f9b3b62bbdc372a889de8782d7f048c653a447417a7d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '71079b009646bbc283137100ad750a0855c50070b5759c75dc20dc74483ed944',
     armv7l: '71079b009646bbc283137100ad750a0855c50070b5759c75dc20dc74483ed944',
       i686: '61f5ee9493aa1aaf9d5c7239ace09dda594a6c14a4dfe2b573d7336c874c87e4',
     x86_64: 'fae469a19281c70bfd5acb7f37ade047b79f7250782578d057ef0cdd28d82809'
  })

  depends_on 'glibc' # R
  depends_on 'libedit' # R
  depends_on 'readline' => :build
  depends_on 'zlibpkg' # R
  depends_on 'ncurses' # R

  configure_options '--enable-shared \
    --enable-editline \
    --enable-readline \
    --enable-fts3 \
    --enable-session \
    --with-pic'
end
