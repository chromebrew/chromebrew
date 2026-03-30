require 'buildsystems/rust'

class Tealdeer < RUST
  description 'A very fast implementation of tldr in Rust.'
  homepage 'https://tealdeer-rs.github.io/tealdeer/'
  version '1.8.1'
  license 'Apache-2.0, MIT'
  compatibility 'all'
  source_url 'https://github.com/tealdeer-rs/tealdeer.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e639ffb547ccbf4ee97270393458ba4b55ca688a729526d07991c241c8b00da8',
     armv7l: 'e639ffb547ccbf4ee97270393458ba4b55ca688a729526d07991c241c8b00da8',
       i686: '2e61fbdb1ed8a41706d8a59a669ed66fb50c68f54c88732226638c95d1bdbd24',
     x86_64: '91d9929ed05d09459a77ac0ca6d459248d8acac04b0afb388d8c99ca06e0f32d'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'rust' => :build

  conflicts_with 'tldr'
end
