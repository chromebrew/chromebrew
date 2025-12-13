require 'buildsystems/autotools'

class Gambit < Autotools
  description 'Efficient implementation of the Scheme programming language'
  homepage 'https://gambitscheme.org/'
  version '4.9.7'
  license 'CC0-1.0'
  compatibility 'all'
  source_url 'https://github.com/gambit/gambit.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f920b14b1b2a41302bb567b814462487550e295db2f6d5233e2c2cce622902d4',
     armv7l: 'f920b14b1b2a41302bb567b814462487550e295db2f6d5233e2c2cce622902d4',
       i686: '277d10da5358567ed6e304401c2dabd191dcb0e0f9efbd6aacb026615573c350',
     x86_64: '98c87a039acf96a369541b969b1ef945f99873fc2e5554eacba4c1a54d4ad204'
  })

  depends_on 'glibc' # R
  depends_on 'openssl' # R

  autotools_configure_options '--enable-openssl'
  run_tests
end
