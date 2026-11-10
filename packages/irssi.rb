require 'buildsystems/meson'

class Irssi < Meson
  description 'Modular text mode IRC client with Perl scripting'
  homepage 'https://irssi.org/'
  version '1.4.5'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/irssi/irssi.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a50a73a1defc56bdd4c28cbbbc09a1e12aeaa0da31452b58f2c6fce26a531ee2',
     armv7l: 'a50a73a1defc56bdd4c28cbbbc09a1e12aeaa0da31452b58f2c6fce26a531ee2',
       i686: '3582bc4fd81da5a21857e11fc6029bd241e6f80fb8e0a6e1ecce9f4178f60e8b',
     x86_64: 'd1852d513ad6701eaa1a870aedf108e00051284a0c5d29f0b44027988f7c1762'
  })

  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libgcrypt' => :library
  depends_on 'libotr' => :library
  depends_on 'libxcrypt' => :library
  depends_on 'ncurses' => :executable
  depends_on 'openssl' => :executable
  depends_on 'perl' => :library
  depends_on 'py3_meson' => :build
  depends_on 'utf8proc' => :executable

  meson_options " \
    -Dc_args='-O3 -pipe -ffat-lto-objects -fPIC -fuse-ld=mold -flto=auto -I#{CREW_PREFIX}/include/ncursesw' \
    -Denable-true-color=yes"
end
