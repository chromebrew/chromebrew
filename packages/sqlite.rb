require 'buildsystems/autotools'

class Sqlite < Autotools
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'https://www.sqlite.org/'
  version '3.53.1'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://github.com/sqlite/sqlite.git'
  git_hashtag "version-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a04f32e410a978fe63d56adb467675ff712253bec97b276fb0adee659ebf0705',
     armv7l: 'a04f32e410a978fe63d56adb467675ff712253bec97b276fb0adee659ebf0705',
       i686: 'c7597a3a9b32af7366ac17d3d4d5031ed11edfdb1f6e297cf1fb5fa51a75129a',
     x86_64: 'f2376b78b38299979fa68112ab8ca04071a41db101b04b7d2a47ef36e8539a49'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libedit' => :executable
  depends_on 'ncurses' => :executable
  depends_on 'readline' => :build
  depends_on 'zlib' => :library

  autotools_configure_options '--enable-rtree \
    --enable-shared \
    --enable-editline \
    --enable-readline \
    --enable-fts3 \
    --enable-fts4 \
    --enable-fts5 \
    --enable-session'
end
