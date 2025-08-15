require 'buildsystems/meson'

class Libwpe < Meson
  description 'General-purpose library for WPE WebKit'
  homepage 'https://wpewebkit.org'
  version '1.16.2'
  license 'BSD-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/WebPlatformForEmbedded/libwpe.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '450d4c896471afef86b0221833d9211ceaf7cc37b731295dc727203d3eded303',
     armv7l: '450d4c896471afef86b0221833d9211ceaf7cc37b731295dc727203d3eded303',
     x86_64: '34216a2089926b04202ac834408e9b2da0aab8ad051516cabb096213527a10d7'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' => :build
  depends_on 'libxkbcommon'
end
