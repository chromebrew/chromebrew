require 'buildsystems/cmake'

class Weechat < CMake
  description 'WeeChat is a fast, light and extensible chat client.'
  homepage 'https://weechat.org/'
  version '4.10.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/weechat/weechat.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c0997ee6732ae097bc11b2027b4f886ed9ac20892e01ffced19885e28352fe4b',
     armv7l: 'c0997ee6732ae097bc11b2027b4f886ed9ac20892e01ffced19885e28352fe4b',
       i686: '280dc20f483dfdded0ef0ba18075f2f01d7c36f09cd9a770b9bf2ac951b8deef',
     x86_64: '41c3c629dc85d18b3886b6d387c0384ebd630b6a78e061123d5b9758f5b8d6a5'
  })

  depends_on 'aspell' => :library
  depends_on 'bdwgc' => :library
  depends_on 'cjson' => :library
  depends_on 'curl' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gnutls' => :library
  depends_on 'guile' => :library
  depends_on 'libgcrypt' => :library
  depends_on 'libiconv' => :library
  depends_on 'libxcrypt' => :library
  depends_on 'lua' => :library
  depends_on 'ncurses' => :executable
  depends_on 'perl' => :library
  depends_on 'python3' => :library
  depends_on 'ruby' => :library
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library

  cmake_options '-DENABLE_PHP=OFF -DENABLE_TCL=OFF'
end
