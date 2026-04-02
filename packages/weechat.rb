require 'buildsystems/cmake'

class Weechat < CMake
  description 'WeeChat is a fast, light and extensible chat client.'
  homepage 'https://weechat.org/'
  version '4.9.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/weechat/weechat.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f3802c2f378453c523ea753739777dcedc8dfae4d2ed7aeebda6c265ed273d17',
     armv7l: 'f3802c2f378453c523ea753739777dcedc8dfae4d2ed7aeebda6c265ed273d17',
       i686: 'd98d291e31145eaa3c6987d0434f25d18872626eb3438655777d8e6e0fd124c1',
     x86_64: '82836a1f3999389af5b4bbe3f58fb2e128cde8b7eb437d99aba13c8fd36f65d6'
  })

  depends_on 'aspell' => :library
  depends_on 'bdwgc' => :library
  depends_on 'cjson' => :library
  depends_on 'curl'
  depends_on 'curl' => :executable
  depends_on 'glibc' => :library
  depends_on 'gnutls' => :library
  depends_on 'guile' => :library
  depends_on 'libgcrypt' => :library
  depends_on 'libxcrypt' => :library
  depends_on 'lua' => :library
  depends_on 'ncurses'
  depends_on 'ncurses' => :executable
  depends_on 'perl' => :library
  depends_on 'python3' => :library
  depends_on 'ruby' => :library
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library

  cmake_options '-DENABLE_PHP=OFF -DENABLE_TCL=OFF'
end
