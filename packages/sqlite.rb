require 'buildsystems/autotools'

class Sqlite < Autotools
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'https://www.sqlite.org/'
  version '3.52.0'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://github.com/sqlite/sqlite.git'
  git_hashtag "version-#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '65c6dff0ebf8a180b1e5f233fbe1f312af77e7dcdaa5fab332f4fc197261a6c3',
     armv7l: '65c6dff0ebf8a180b1e5f233fbe1f312af77e7dcdaa5fab332f4fc197261a6c3',
       i686: '83739029d750653060c95bd0c037f7b6194d19d6a40baf7b3cd0198b828499bb',
     x86_64: '288a07aaaa1acfc6196f139b8630fc12caab3869fbbfcfd98ab2fbc55e39131e'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'libedit' => :executable
  depends_on 'ncurses' => :executable
  depends_on 'readline' => :build
  depends_on 'zlib' => :library

  autotools_configure_options '--enable-shared \
    --enable-editline \
    --enable-readline \
    --enable-fts3 \
    --enable-fts4 \
    --enable-fts5 \
    --enable-session'
end
