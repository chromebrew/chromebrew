require 'buildsystems/rust'

class Navi < RUST
  description 'An interactive cheatsheet tool for the command-line'
  homepage 'https://github.com/denisidoro/navi'
  version '2.24.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/denisidoro/navi.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3d38b2e94028057c3e82a65ce1c442c33909f09e2dc19d343d0184ef74200801',
     armv7l: '3d38b2e94028057c3e82a65ce1c442c33909f09e2dc19d343d0184ef74200801',
       i686: 'cd09c6f3aba3d702ea648b78701a8947b48cf214bc4a836bac3d46820309124e',
     x86_64: 'd0ac52a0b7969f49c2a9a11e70b7a988c7a01a71beda2f69f5ba78d88d41c01a'
  })

  depends_on 'fzf' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'rust' => :build
  depends_on 'tealdeer' # R
end
