require 'buildsystems/autotools'

class Fakeroot < Autotools
  description 'Run a command in an environment faking root privileges for file manipulation.'
  homepage 'https://wiki.debian.org/FakeRoot'
  version '2.1.4'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://salsa.debian.org/clint/fakeroot.git'
  git_hashtag "upstream/#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '66de868d7cc8d7841bc7501d683784a7a17e9fc6ea6eed5b8bc92d474af5bd2d',
     armv7l: '66de868d7cc8d7841bc7501d683784a7a17e9fc6ea6eed5b8bc92d474af5bd2d',
       i686: '2e3fb0e4d16eb40dbf777cb46aab927a313e104cfe684cb0b79ea0733dc6c9b6',
     x86_64: '894d209140c3bfd3d6fabf6a6a539c2fbf599bb365e9d0cad8a09bc3c7fde4bd'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libcap'

  # https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1074945
  autotools_pre_configure_options 'CFLAGS=-Wno-incompatible-pointer-types'
end
