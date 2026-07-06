require 'buildsystems/cmake'

class Weechat < CMake
  description 'WeeChat is a fast, light and extensible chat client.'
  homepage 'https://weechat.org/'
  version '4.9.3'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/weechat/weechat.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0473d4149d9d0ea42a40e35f249e5731d320a39dfbe3d559e07a8a75ec46772c',
     armv7l: '0473d4149d9d0ea42a40e35f249e5731d320a39dfbe3d559e07a8a75ec46772c',
       i686: 'a5f4046e2a532a5fb3c7aff78532988382b4219e6d096a1241a6d355c811c130',
     x86_64: '0eef73cf874d824b1a783afb24221e81032422251bfcced702735e63a1adf62e'
  })

  depends_on 'aspell' => :library
  depends_on 'bdwgc' => :library
  depends_on 'cjson' => :library
  depends_on 'curl'
  depends_on 'curl' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
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
