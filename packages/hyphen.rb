require 'buildsystems/autotools'

class Hyphen < Autotools
  description 'hyphenation library to use converted TeX hyphenation patterns'
  homepage 'https://github.com/hunspell/hyphen'
  version '2.8.10'
  license 'GPL-2, LGPL-2.1 and MPL-1.1'
  compatibility 'all'
  source_url 'https://github.com/hunspell/hyphen.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'daa7199249cc832145b029f9a9391aacb2370afcc42a15daae2d4d32baa4eb0f',
     armv7l: 'daa7199249cc832145b029f9a9391aacb2370afcc42a15daae2d4d32baa4eb0f',
       i686: '0cbde112513fb00aad97bd0a20bf976eeb5a5a223fccd9f7fdc956104b6f5065',
     x86_64: 'c489b26c9273203fadc3a41912a43cfeb4dac92597cbe9487a2a6d04ee6abb97'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  run_tests
end
