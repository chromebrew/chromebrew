require 'buildsystems/autotools'

class Sqlite < Autotools
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'https://www.sqlite.org/'
  version '3.53.0'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://github.com/sqlite/sqlite.git'
  git_hashtag "version-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '396a408e1384ee5d376e8fa4e6d4b5b0ec891fccc96e200cc0e0f26a0718c8b3',
     armv7l: '396a408e1384ee5d376e8fa4e6d4b5b0ec891fccc96e200cc0e0f26a0718c8b3',
       i686: 'effc2da5b32e4f4ee0033376312755ce9ff1f247a71540637602f5e94a109702',
     x86_64: '8db688135c4833dd903bbeed12487e73663820abee0522da12846a4c383b2cd8'
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
