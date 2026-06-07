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
    aarch64: '580c0f4bbfe3e40996d55cf67cdb0d1e7ace7cd41f656681aea1a2dac56354cb',
     armv7l: '580c0f4bbfe3e40996d55cf67cdb0d1e7ace7cd41f656681aea1a2dac56354cb',
       i686: '64e77d9799c0ab41113cd14e51c8b1bf2dbb4e91ff482c87d3d64c8b437e4c2f',
     x86_64: '0567105c3962e72215185d8e638dc7036de7dd1b57de0b7f870e14df7a1a657f'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'rust' => :build
end
