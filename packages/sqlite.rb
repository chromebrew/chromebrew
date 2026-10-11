require 'buildsystems/autotools'

class Sqlite < Autotools
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'https://www.sqlite.org/'
  version '3.54.0'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://github.com/sqlite/sqlite.git'
  git_hashtag "version-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '124931da66ffe2aec11f96406ba66104323a4fccd29a42138fba290caa14f98b',
     armv7l: '124931da66ffe2aec11f96406ba66104323a4fccd29a42138fba290caa14f98b',
       i686: 'a9947d0d860eb7bdd6dc99abde848c4e5d021d1148e5ffbe372bf79ccf402616',
     x86_64: '9973f224a3f26341d9cbd98bf13303a28771bc2705b556068e6035b78b70ebe7'
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
