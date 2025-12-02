require 'buildsystems/autotools'

class Sqlite < Autotools
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'https://www.sqlite.org/'
  version '3.51.1'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://github.com/sqlite/sqlite.git'
  git_hashtag "version-#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ca56ffae1ba36aca938f3f10a8c7cb36e39e45c518ceacf057c9b146fe98460a',
     armv7l: 'ca56ffae1ba36aca938f3f10a8c7cb36e39e45c518ceacf057c9b146fe98460a',
       i686: 'b13951cfb24759a9aee7013f6ca881fd1846f2271a5d34e5c77ee738ec973def',
     x86_64: '4e8fab614ee2fde12d618d567edf2ba00baad57214acb0d73fe0291202ac67aa'
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
