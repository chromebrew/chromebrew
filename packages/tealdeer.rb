require 'buildsystems/rust'

class Tealdeer < RUST
  description 'A very fast implementation of tldr in Rust.'
  homepage 'https://tealdeer-rs.github.io/tealdeer/'
  version '1.8.0'
  license 'Apache-2.0, MIT'
  compatibility 'all'
  source_url 'https://github.com/tealdeer-rs/tealdeer.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '814f8deaec35a3c0947f320d9db6835cba9a189da48fc55db0201c0186d31ca8',
     armv7l: '814f8deaec35a3c0947f320d9db6835cba9a189da48fc55db0201c0186d31ca8',
       i686: '8f0b10662ebd2fcebb3d1ca3650ef5dc3299eb35b18e9d8c04a599139a6d332e',
     x86_64: '8f116680132091b4a84646214cc639b28038c52dd9c2f79341f9b742abb5e812'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'rust' => :build

  conflicts_with 'tldr'
end
