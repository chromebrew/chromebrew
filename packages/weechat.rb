require 'buildsystems/cmake'

class Weechat < CMake
  description 'WeeChat is a fast, light and extensible chat client.'
  homepage 'https://weechat.org/'
  version '4.9.1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/weechat/weechat.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4d063e2ba09a587130eeeaf095f87634654388ae883e44a1d2b7fb751b0dd8e0',
     armv7l: '4d063e2ba09a587130eeeaf095f87634654388ae883e44a1d2b7fb751b0dd8e0',
       i686: 'd6886900304502f7dc16bc021bf85f5ef86dea769a5040e4ad85a1ea7a9bf79e',
     x86_64: '074ed6e50f26f4721306413d1be74ed3a40759b889016fa3a8af43f22d565570'
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
