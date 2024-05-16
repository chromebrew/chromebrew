require 'buildsystems/autotools'

class Gmime < Autotools
  description 'GMime is a powerful MIME (Multipurpose Internet Mail Extension) utility library. It is meant for creating, editing, and parsing MIME messages and structures.'
  homepage 'https://developer.gnome.org/gmime/'
  version '3.2.14-de4f1b0'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/jstedfast/gmime.git'
  git_hashtag 'de4f1b044141df3ef0b1fc20be422dc667443484'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '64a5336aa9c72b3afb128b124c24a09d229e787915c1d17b0874e1775d98e9ea',
     armv7l: '64a5336aa9c72b3afb128b124c24a09d229e787915c1d17b0874e1775d98e9ea',
     x86_64: 'db5b68e4c23881dfe323a660d14d9f5112f79c998bdf98dad5f5fb19123afcbd'
  })

  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gpgme' # R
  depends_on 'libassuan' # R
  depends_on 'libgpgerror' # R
  depends_on 'libidn2' # R
  depends_on 'libunistring' # R
  depends_on 'vala' => :build
  depends_on 'zlibpkg' # R

  gnome
end
