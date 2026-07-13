require 'buildsystems/autotools'

class Minerd < Autotools
  description 'CPU miner for Litecoin and Bitcoin'
  homepage 'https://github.com/pooler/cpuminer'
  version '2.5.1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/pooler/cpuminer.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a6be8bbbd7b0bbddf383ddd7eb280a7cf5099b2183ba5c67eec06bfabcc62f63',
     armv7l: 'a6be8bbbd7b0bbddf383ddd7eb280a7cf5099b2183ba5c67eec06bfabcc62f63',
       i686: 'd194f08920ad6a668027fa42b9bca49bd302ddf8d46b406993e1f38c9474f044',
     x86_64: '4f109da12beed9cf7054b5bb31432e79d6c2d88aebe9861405ead57a583f4ca5'
  })

  depends_on 'curl' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'jansson' => :executable
end
