require 'buildsystems/autotools'

class Snooze < Autotools
  description 'run a command at a particular time'
  homepage 'https://github.com/leahneukirchen/snooze'
  version '0.5.1'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://github.com/leahneukirchen/snooze.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f48d06febfefcc412dbeb9f73a64e77b42ab190b24b81d0a88cf2e2cba745502',
     armv7l: 'f48d06febfefcc412dbeb9f73a64e77b42ab190b24b81d0a88cf2e2cba745502',
       i686: '5c5c33c134230a1e38f03e956993e257ee2fed4210286e4b48e3b3cc92e44599',
     x86_64: 'b4516653203371b802e40dc6d428be3e11800b87646f06aa9d1e4cffc328dfb4'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  autotools_skip_configure
end
