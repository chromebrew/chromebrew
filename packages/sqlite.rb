require 'buildsystems/autotools'

class Sqlite < Autotools
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'https://www.sqlite.org/'
  version '3.51.2'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://github.com/sqlite/sqlite.git'
  git_hashtag "version-#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cd816a90cd19818cceb254adc68e24c64fb675428b6c97d20000303e332696fb',
     armv7l: 'cd816a90cd19818cceb254adc68e24c64fb675428b6c97d20000303e332696fb',
       i686: 'e22b6746fc23fc4a830b8152ea41abfc415011e7baee4270d8aaa11b2a7eba97',
     x86_64: '11e0a5b16b0120ac87788cd94cf6f8f8f7696a0f6468a42d6c024f26162baafa'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libedit' # R
  depends_on 'ncurses' # R
  depends_on 'readline' => :build
  depends_on 'zlib' # R

  autotools_configure_options '--enable-shared \
    --enable-editline \
    --enable-readline \
    --enable-fts3 \
    --enable-fts4 \
    --enable-fts5 \
    --enable-session'
end
