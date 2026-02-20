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
    aarch64: 'bdc40c8b7a89a034d7d606a80291b9c27557f860bd8ac41f52b89b501d32161e',
     armv7l: 'bdc40c8b7a89a034d7d606a80291b9c27557f860bd8ac41f52b89b501d32161e',
       i686: '949f614b7101f8545490f33a331761e505edeb231ac0dbc6b039c0595f325bfe',
     x86_64: '3571a86b7c78175c28cdbe7233cad9f67bd108eeb5ccf813ddceac9d2e52d3ba'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libedit' => :executable_only
  depends_on 'ncurses' => :executable_only
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
