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
    aarch64: 'f12a65edbe178005d327bd8b1b1e588069c0ecf68d462bef131484303e126693',
     armv7l: 'f12a65edbe178005d327bd8b1b1e588069c0ecf68d462bef131484303e126693',
     x86_64: '03685ced49d6465267400e606a74ef9a7296c76eeae798b7804caa99948ab29c'
  })

  depends_on 'libxext' => :build
  depends_on 'libx11' => :build
  depends_on 'glibc' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
end
