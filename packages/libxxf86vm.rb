require 'buildsystems/meson'

class Libxxf86vm < Meson
  description 'X.org the client library for the XFree86-VidMode X extension.'
  homepage 'https://www.x.org/wiki/'
  version '1.1.6-63134ba'
  license 'custom'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxxf86vm.git'
  git_hashtag '63134ba6acf046099fc112e08942ff6549f2286a'
  # git_hashtag "libXxf86vm-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1b557e148bb31223dd3a97bab29ce8ccf666632e6e5fce6ce96226d666284493',
     armv7l: '1b557e148bb31223dd3a97bab29ce8ccf666632e6e5fce6ce96226d666284493',
     x86_64: 'fcfdd4e20c228aae10d7b671d6088a335b883bc07efec143db5d389fc080c5c9'
  })

  depends_on 'libxext' => :build
  depends_on 'libx11' => :build
  depends_on 'glibc' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
end
