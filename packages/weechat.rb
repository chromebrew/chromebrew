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
    aarch64: '80467b49de29172dbefc391ebb7d5c38aab3b93e1dad48d33ced8affa479da98',
     armv7l: '80467b49de29172dbefc391ebb7d5c38aab3b93e1dad48d33ced8affa479da98',
       i686: 'a433ba966c9177d0893a37bc2e80bd85e4e6d0ca138ff1a82cf2eb9efdf88fb6',
     x86_64: 'ff11d821f64e29f738da78aba27f3a0d4850f9b5fc6c1c76d5ec150e5281e34b'
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
  depends_on 'libiconv' => :library
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
