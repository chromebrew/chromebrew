require 'buildsystems/autotools'

class Detox < Autotools
  description 'detox is a program that renames files to make them easier to work with under Linux and other Unix-like operating systems.'
  homepage 'https://github.com/dharple/detox'
  version '3.0.1'
  license 'BSD-3 Clause'
  compatibility 'all'
  source_url 'https://github.com/dharple/detox.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '63b3f1aed4cca8017ea6ff5c7188c9ea1ad30627debbe0825220a9ce1ecb0c12',
     armv7l: '63b3f1aed4cca8017ea6ff5c7188c9ea1ad30627debbe0825220a9ce1ecb0c12',
       i686: 'bbc10e0d040d9cab86b60cfdb7514f71f33084d44e37a7a72faf2433bac50049',
     x86_64: 'f6075327c543f7896d7747f42c45e7c043ade6d4628b80f56daaccdae594297b'
  })

  depends_on 'glibc' # R
end
