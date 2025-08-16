require 'buildsystems/autotools'

class Sqlite < Autotools
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'https://www.sqlite.org/'
  version '3.50.4'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://github.com/sqlite/sqlite.git'
  git_hashtag "version-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e34ccf2a5d6458959a8a4ff59a480ad6125685d00a52480cbd41e4955e8b4c9d',
     armv7l: 'e34ccf2a5d6458959a8a4ff59a480ad6125685d00a52480cbd41e4955e8b4c9d',
       i686: '2e66a04a245e2e25b62ddff2e4fdec7129fcaa42f6e5a8813cbb5a95ddb017ff',
     x86_64: '3c1a3bde311155b4d46c525eded402e4a93e887e23b3501a151da5f1fe1d06a5'
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
    --enable-session'
end
