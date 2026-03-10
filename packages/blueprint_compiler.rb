require 'buildsystems/meson'

class Blueprint_compiler < Meson
  description 'A markup language for GTK user interfaces'
  homepage 'https://gitlab.gnome.org/GNOME/blueprint-compiler'
  version '0.20.0'
  license 'LGPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/blueprint-compiler.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '44c43509e1e77f5fcb82dbb3ee37f13c212a3df3fcb4cb41c9f46fa4c4e17d9e',
     armv7l: '44c43509e1e77f5fcb82dbb3ee37f13c212a3df3fcb4cb41c9f46fa4c4e17d9e',
     x86_64: '944f06851e44b2a0ca10e2cf6d75f23c2066e02545c2fb84c807281d62b922e9'
  })

  depends_on 'py3_pygobject' # R
end
