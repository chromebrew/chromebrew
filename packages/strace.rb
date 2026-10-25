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
    aarch64: '01dffb8827a8602174f77133d7faa3d2987ca0119dea0c4bad28b48066650bd2',
     armv7l: '01dffb8827a8602174f77133d7faa3d2987ca0119dea0c4bad28b48066650bd2',
     x86_64: 'de26e9aaa914fd8cabf27a111ecd3086520e5495d2c3c8a8df3867024cceb236'
  })

  depends_on 'elfutils' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  autotools_configure_options '--disable-mpers --with-libdw --disable-gcc-Werror'
end
