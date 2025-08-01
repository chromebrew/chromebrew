require 'buildsystems/autotools'

class Libice < Autotools
  description 'X.org X Inter Client Exchange Library'
  homepage 'https://www.x.org/wiki/'
  version '1.1.2'
  license 'X11'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libice.git'
  git_hashtag "libICE-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '69815ffd1178e0c19ad9f8a4d4b8fc7b34aeb09c7aaae0c4a8c70692fdc61fe1',
     armv7l: '69815ffd1178e0c19ad9f8a4d4b8fc7b34aeb09c7aaae0c4a8c70692fdc61fe1',
     x86_64: 'a476eef6ec924b373c9f3b68e4ec19ce35fd7b10b5c9c5381c464b5f0d46b78b'
  })

  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libx11' => :build
  depends_on 'libxtrans' => :build
end
