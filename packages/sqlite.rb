require 'buildsystems/autotools'

class Sqlite < Autotools
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'http://www.sqlite.org/'
  version '3.44.0'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://www.sqlite.org/2023/sqlite-autoconf-3440000.tar.gz'
  source_sha256 'b9cd386e7cd22af6e0d2a0f06d0404951e1bef109e42ea06cc0450e10cd15550'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.44.0_armv7l/sqlite-3.44.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.44.0_armv7l/sqlite-3.44.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.44.0_i686/sqlite-3.44.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sqlite/3.44.0_x86_64/sqlite-3.44.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a66eadf880d9aa526d157fbe918c0a01cb58b48f33d596ec9186117177168338',
     armv7l: 'a66eadf880d9aa526d157fbe918c0a01cb58b48f33d596ec9186117177168338',
       i686: 'f7ce6e49d8d3bb5890ff764922049042caedb237683604f656257de6dfcca8b6',
     x86_64: '9360e906192dd29e793a6b0de084f244430b6d5a5cbbfa114924b430d6df4a10'
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
