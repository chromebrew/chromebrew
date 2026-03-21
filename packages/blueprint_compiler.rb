require 'buildsystems/meson'

class Blueprint_compiler < Meson
  description 'A markup language for GTK user interfaces'
  homepage 'https://gitlab.gnome.org/GNOME/blueprint-compiler'
  version '0.20.4'
  license 'LGPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/blueprint-compiler.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '334682bcf9120e3bfa85ebfac14182a4fd06e41622a16611cab0d5c6d95f9b80',
     armv7l: '334682bcf9120e3bfa85ebfac14182a4fd06e41622a16611cab0d5c6d95f9b80',
     x86_64: '2b750fb75257c8edc0286be6bd5dacbc41f1d3821bfb0a94235fd6951acd6e80'
  })

  depends_on 'py3_pygobject' # R
end
