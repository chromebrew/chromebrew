require 'buildsystems/autotools'

class Rgb < Autotools
  description 'X color name database'
  homepage 'https://xorg.freedesktop.org/wiki/'
  version '1.1.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/app/rgb.git'
  git_hashtag "rgb-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '83955fe52361625e21dd9a7d97a9b43f5c83fe2a3b07946bab59ebe89e2692b5',
     armv7l: '83955fe52361625e21dd9a7d97a9b43f5c83fe2a3b07946bab59ebe89e2692b5',
     x86_64: '9da27cdae896ec53d23bfe370687dc15181cdad0e16e1c96a1b5498d71c301fd'
  })

  depends_on 'xorg_proto' => :build
  depends_on 'xorg_macros' => :build
end
