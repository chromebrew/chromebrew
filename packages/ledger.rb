require 'buildsystems/cmake'

class Ledger < CMake
  description 'A double-entry accounting system with a command-line reporting interface'
  homepage 'https://www.ledger-cli.org/'
  version '3.3.2'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/ledger/ledger.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ledger/3.3.2_armv7l/ledger-3.3.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ledger/3.3.2_armv7l/ledger-3.3.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ledger/3.3.2_i686/ledger-3.3.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ledger/3.3.2_x86_64/ledger-3.3.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a078d15274360b4f03558eca8ac4128536bffa774d3bc0a432802f89369b19c3',
     armv7l: 'a078d15274360b4f03558eca8ac4128536bffa774d3bc0a432802f89369b19c3',
       i686: '8ba30162cc4c1b55a6e47e590bde549b24e7a91dfbdc2f7f04870069897891ce',
     x86_64: 'e15d098bd64cd861eead5b792cf74703dd1a98b0e3adecda13baeb6cc4ef3fe1'
  })

  depends_on 'boost' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'libedit' # R
  depends_on 'mpfr' # R
end
