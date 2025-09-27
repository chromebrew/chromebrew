require 'buildsystems/meson'

class Libinih < Meson
  description 'A simple .INI file parser written in C'
  homepage 'https://github.com/benhoyt/inih'
  version '62'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/benhoyt/inih.git'
  git_hashtag "r#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '722179e4994ecf8a7007125a2113eafe4e18b306a8418d804b6b8bd3ad32517c',
     armv7l: '722179e4994ecf8a7007125a2113eafe4e18b306a8418d804b6b8bd3ad32517c',
       i686: 'c1ad6de9a7406b205e202cc210270b0fee013c25011e104140035c695a005af4',
     x86_64: '7267705ecd92c5b4168b5b59b29b15909ca5490fd2b307626d022e7be50b9b10'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  meson_options '-Ddistro_install=true \
      -Dwith_INIReader=true'
end
