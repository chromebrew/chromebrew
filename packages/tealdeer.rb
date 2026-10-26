require 'buildsystems/rust'

class Tealdeer < RUST
  description 'A very fast implementation of tldr in Rust.'
  homepage 'https://tealdeer-rs.github.io/tealdeer/'
  version '1.9.1'
  license 'Apache-2.0, MIT'
  compatibility 'all'
  source_url 'https://github.com/tealdeer-rs/tealdeer.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e18dce60b8e8b70a18c2fb85e16f9792f009e5f8c8618e4d54505c8373115ef5',
     armv7l: 'e18dce60b8e8b70a18c2fb85e16f9792f009e5f8c8618e4d54505c8373115ef5',
       i686: 'f70726b5dba7624521dd459ad832a87d67acfb5abcfc04678ebe2f971cfdcb9a',
     x86_64: 'afc603d87a4e714c0b747fa46fbd2488a53897c50b6557d5a301099e7826e83f'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'rust' => :build

  conflicts_with 'tldr'
end
