require 'buildsystems/autotools'

class Fakeroot < Autotools
  description 'Run a command in an environment faking root privileges for file manipulation.'
  homepage 'https://wiki.debian.org/FakeRoot'
  version '1.38.1'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://deb.debian.org/debian/pool/main/f/fakeroot/fakeroot_#{version}.orig.tar.gz"
  source_sha256 '37c5063942efe2e2aeefd6e71ae2690bcb9b7d512c53bc6409b54d0730cbdac1'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1274e476209268870ada3efd8286adad121f74e87964299dbb617d9a46eb5348',
     armv7l: '1274e476209268870ada3efd8286adad121f74e87964299dbb617d9a46eb5348',
       i686: 'bdc9cc24c2904b5b3017fb95e195ddceaaa9a00716019ac8d9da762fb946e7df',
     x86_64: ''
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libcap'

  # https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1074945
  autotools_pre_configure_options 'CFLAGS=-Wno-incompatible-pointer-types'
end
