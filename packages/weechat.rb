require 'buildsystems/cmake'

class Weechat < CMake
  description 'WeeChat is a fast, light and extensible chat client.'
  homepage 'https://weechat.org/'
  version '4.10.3'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/weechat/weechat.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4132242373b1cab03ed042a5b63e23b2f24cb303a81f0675da9261d77e8b03b1',
     armv7l: '4132242373b1cab03ed042a5b63e23b2f24cb303a81f0675da9261d77e8b03b1',
       i686: '718a7ee8e1bd16f79eb8af0aa9b89c0394ad8937b7159288536cd11e06fb2fe2',
     x86_64: 'f1d85b8cd74616eb71c47f6fb3e77fd67a7176acc3e36381f16c912b570064cc'
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
