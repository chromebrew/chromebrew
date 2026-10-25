require 'buildsystems/autotools'

class Strace < Autotools
  description 'strace is a diagnostic, debugging and instructional userspace utility for Linux.'
  homepage 'https://strace.io/'
  version '7.3'
  license 'BSD'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://strace.io/files/#{version}/strace-#{version}.tar.xz"
  source_sha256 '529634c40910895a9a1f3c5c1e65da2ca9ed72fb158dfc4bcc89efdf05e39b72'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '203b32fa2b8e2fc79a9605eef07e93533c770ad982a35f5ac89e43e293c35c3b',
     armv7l: '203b32fa2b8e2fc79a9605eef07e93533c770ad982a35f5ac89e43e293c35c3b',
     x86_64: 'ea00f6793a9be9467c41e1941ccb03daee79f3709c771f030fe12e1d2a257b4a'
  })

  depends_on 'elfutils' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  autotools_configure_options '--disable-mpers --with-libdw --disable-gcc-Werror'
end
