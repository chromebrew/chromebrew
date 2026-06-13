require 'buildsystems/meson'

class Iputils < Meson
  description 'A set of small useful utilities for Linux networking.'
  homepage 'https://github.com/iputils/iputils'
  version '20250605'
  license 'GPL-2, BSD-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/iputils/iputils.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c2449c8e3dc9b8214f057df980ae203538bef3aa4943971fdc9ab085e6e5b0b3',
     armv7l: 'c2449c8e3dc9b8214f057df980ae203538bef3aa4943971fdc9ab085e6e5b0b3',
     x86_64: '8af2447b0919cc0f6dac4d599cafc6511233b17c824a7586b0d9d39ce8dcf5c0'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libcap' => :executable
  depends_on 'libidn2' => :executable
  depends_on 'libxslt' => :build

  meson_options '-DSKIP_TESTS=true'
end
