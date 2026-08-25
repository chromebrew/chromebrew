require 'buildsystems/rust'

class Tealdeer < RUST
  description 'A very fast implementation of tldr in Rust.'
  homepage 'https://tealdeer-rs.github.io/tealdeer/'
  version '1.9.0'
  license 'Apache-2.0, MIT'
  compatibility 'all'
  source_url 'https://github.com/tealdeer-rs/tealdeer.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '22130ebf8271e9c35f38290906268a3bfeccf6c182343c412f8488a59008c16c',
     armv7l: '22130ebf8271e9c35f38290906268a3bfeccf6c182343c412f8488a59008c16c',
       i686: '644db9df76b241f2c67347667763aeba949363f2d91bec8c6c9aafd13314fef1',
     x86_64: 'ab5a31c06ab1bb5078e3dcbb456448e754e4d197b49b45559e71cb73807f4582'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'rust' => :build

  conflicts_with 'tldr'
end
