require 'buildsystems/autotools'

class Sqlite < Autotools
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'https://www.sqlite.org/'
  version '3.50.4-1'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://github.com/sqlite/sqlite.git'
  git_hashtag "version-#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ca67b5a566ec0298a523dc3e2cdf018278e8f46b7d556c7d2e17bc7c111aa933',
     armv7l: 'ca67b5a566ec0298a523dc3e2cdf018278e8f46b7d556c7d2e17bc7c111aa933',
       i686: '3df21d0757e297602d8e1f33916c4d083a4676348d0983d96fd9901e5a938278',
     x86_64: 'cbb8cc1aebd650e8ca9d0daac9311be7528acc92ae9fc3a46e836cd3220d0cc6'
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
