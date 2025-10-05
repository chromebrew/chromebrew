require 'buildsystems/autotools'

class Bdftopcf < Autotools
  description 'BDF to PCF font converter for X11'
  homepage 'https://gitlab.freedesktop.org/xorg/util/bdftopcf'
  version '1.1.2'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/util/bdftopcf.git'
  git_hashtag "bdftopcf-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '26692c910819cfa4ec5afa8e002b576a02b3d0c1c66fe895c7b9b45d83369f77',
     armv7l: '26692c910819cfa4ec5afa8e002b576a02b3d0c1c66fe895c7b9b45d83369f77',
     x86_64: '8cdc1cc4ed48f54fab9a08f989c0e0bdf678a522a473cd62e25ad8c3d6ee54ff'
  })

  depends_on 'libxfont2' => :build
  depends_on 'xorg_macros' => :build
  depends_on 'xorg_proto' => :build
end
