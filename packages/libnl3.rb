require 'buildsystems/autotools'

class Libnl3 < Autotools
  description 'libnl is a library for applications dealing with netlink sockets.'
  homepage 'https://github.com/thom311/libnl'
  version '3.9.0'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/thom311/libnl.git'
  git_hashtag "libnl#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e78307d62f182317cfd64bc7f009d6ebee55338c25df46e2e86ed0e1289be93a',
     armv7l: 'e78307d62f182317cfd64bc7f009d6ebee55338c25df46e2e86ed0e1289be93a',
       i686: '8f05af9fc50c552a1e40b635336da213e948ee736fcc7b5ac9d21e67ca606baa',
     x86_64: '84183099ad2f31076fe48d7fe6b31f82581d7d621f8b30fbf41c4350e3414e67'
  })

  # depends_on 'check' => :build
  depends_on 'glibc' # R

  configure_options '--disable-debug'
  # https://github.com/thom311/libnl/issues/393
  # run_tests
end
