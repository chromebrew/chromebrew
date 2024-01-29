require 'buildsystems/autotools'

class Xzutils < Autotools
  description 'XZ Utils is free general-purpose data compression software with a high compression ratio.'
  homepage 'http://tukaani.org/xz/'
  version '5.4.6'
  license 'public-domain70651c6d7d0301739b6ef1c88a116004e2cff05abb8e3e2e83d3dd8a6cf7222f LGPL-2.1+ and GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/tukaani-project/xz/releases/download/v5.4.6/xz-5.4.6.tar.xz'
  source_sha256 'b92d4e3a438affcf13362a1305cd9d94ed47ddda22e456a42791e630a5644f5c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '70651c6d7d0301739b6ef1c88a116004e2cff05abb8e3e2e83d3dd8a6cf7222f',
     armv7l: '70651c6d7d0301739b6ef1c88a116004e2cff05abb8e3e2e83d3dd8a6cf7222f',
       i686: 'b87a8080bda5d334f7749fe0d13a26332f38764b41f40f82b364e345efc0b051',
     x86_64: 'e411899c36c64fa9e7bad354ee2733c33bfcaf9d6a55133ca80e66c10fea9df0'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'glibc' # R

  configure_options '--enable-shared'
  run_tests
end
