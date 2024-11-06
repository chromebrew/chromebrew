require 'buildsystems/cmake'

class Weechat < CMake
  description 'WeeChat is a fast, light and extensible chat client.'
  homepage 'https://weechat.org/'
  version '4.4.1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/weechat/weechat.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3755d6351a04f3afd99377e117608113c952a353be98aa9b1ac1c2cbfbe8a565',
     armv7l: '3755d6351a04f3afd99377e117608113c952a353be98aa9b1ac1c2cbfbe8a565',
       i686: '02a64442c7bf8c421c7f947e76020a35fdea9bb04ae3efbc41dae1ea500c04fb',
     x86_64: 'f9018d6a3bd471185516d7a7d2fc70ab37f442458eedd27441d4f6a80d3923fd'
  })

  depends_on 'aspell'
  depends_on 'bdwgc' # R
  depends_on 'cjson'
  depends_on 'curl'
  depends_on 'gnutls'
  depends_on 'guile'
  depends_on 'libgcrypt'
  depends_on 'lua'
  depends_on 'ncurses'
  depends_on 'perl'
  depends_on 'python3'
  depends_on 'ruby'
  depends_on 'tcl'
  depends_on 'zlib'
  depends_on 'zstd'

  cmake_options '-DENABLE_PHP=OFF'
end
