# Adapted from Arch Linux tex-fmt PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=tex-fmt

require 'buildsystems/rust'

class Tex_fmt < RUST
  description 'An extremely fast LaTeX formatter written in Rust'
  homepage 'https://github.com/WGUNDERWOOD/tex-fmt'
  version '0.5.7'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/WGUNDERWOOD/tex-fmt.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f218a357fe7ae26a9dbbc4dd6d5275ff1e2932d70fc33eb432161e8d96f876ed',
     armv7l: 'f218a357fe7ae26a9dbbc4dd6d5275ff1e2932d70fc33eb432161e8d96f876ed',
       i686: '64e77d9799c0ab41113cd14e51c8b1bf2dbb4e91ff482c87d3d64c8b437e4c2f',
     x86_64: 'b87fe3ab4130e9ed230b3684fcde6a64d451f642f66081a66ee32f8aec975cbc'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'rust' => :build
end
