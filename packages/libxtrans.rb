require 'buildsystems/autotools'

class Libxtrans < Autotools
  description 'transport library for the X window system'
  homepage 'https://x.org/wiki/'
  version '1.6.0'
  license 'custom'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxtrans.git'
  git_hashtag "xtrans-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f3367979fb252be087276d57c964fd02e2dd174ed33b9d2c0618c8ab1dcd908b',
     armv7l: 'f3367979fb252be087276d57c964fd02e2dd174ed33b9d2c0618c8ab1dcd908b',
       i686: 'e5e01cd320bdc3e1a37e6307dc0e637fadc750d558801076f9a39104e4f3a43c',
     x86_64: '860a1fa44f884f453c4de4cf40d0ad1ebb27c34421e2c66545ece78c6419535b'
  })
end
