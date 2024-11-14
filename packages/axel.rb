require 'buildsystems/autotools'

class Axel < Autotools
  description 'Light command line download accelerator for Linux and Unix'
  homepage 'https://github.com/axel-download-accelerator/axel'
  version '2.17.14'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/axel-download-accelerator/axel.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '56a0871e20f98947802ee9d6f2c69e360935f225a62769af08deec7afaeb9f9d',
     armv7l: '56a0871e20f98947802ee9d6f2c69e360935f225a62769af08deec7afaeb9f9d',
       i686: '4e497b6887c9284614c64d77067729e44c071869c7405818e5cca3526cf37fee',
     x86_64: '790e5060852e82a88bb3ce21a31a4832f9e932583011f00a120a6d04386236e0'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'openssl' # R
  depends_on 'txt2man' => :build
end
