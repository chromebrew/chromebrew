require 'buildsystems/autotools'

class Libnl3 < Autotools
  description 'libnl is a library for applications dealing with netlink sockets.'
  homepage 'https://github.com/thom311/libnl'
  version '3.9.0-5248e1a'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/thom311/libnl.git'
  git_hashtag '5248e1a45576617b349465997822cef34cbc5053'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '83355357cf4755c47348e8db7528e345a36de0dfa3d734e1141dc632e5970973',
     armv7l: '83355357cf4755c47348e8db7528e345a36de0dfa3d734e1141dc632e5970973',
       i686: '8f9373822534eea9fec8cbdea8b4dac53b94920aae8abc4c9f19264fff0130a3',
     x86_64: '455ffa9f7ba341a84989c0e36546918d671ef61013ddb171264601cc058abe1d'
  })

  # depends_on 'check' => :build
  depends_on 'glibc' # R

  autotools_configure_options '--disable-debug'
  # https://github.com/thom311/libnl/issues/393
  # run_tests
end
