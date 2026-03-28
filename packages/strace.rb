require 'buildsystems/autotools'

class Strace < Autotools
  description 'strace is a diagnostic, debugging and instructional userspace utility for Linux.'
  homepage 'https://strace.io/'
  version '6.19'
  license 'BSD'
  compatibility 'all'
  source_url "https://strace.io/files/#{version}/strace-#{version}.tar.xz"
  source_sha256 'e076c851eec0972486ec842164fdc54547f9d17abd3d1449de8b120f5d299143'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0b564f88270e87fdb1e4ef55d985f7ac5cefa77ab4db9ecef476037cf66e23c3',
     armv7l: '0b564f88270e87fdb1e4ef55d985f7ac5cefa77ab4db9ecef476037cf66e23c3',
       i686: '970f7b5a47fe5a2bd254e8457f3acc8cd70f27f85e9823ca29e48d59e563b6b4',
     x86_64: '03f78a27e21c3535bdbcf79f17fd4322cdd0816e58db84397bb23eed5b147c32'
  })

  depends_on 'elfutils' # Needed for stack trace support
  depends_on 'elfutils' => :executable
  depends_on 'glibc' => :executable

  # This needs to be built with linux headers 5.15 on x86_64 via
  # CREW_KERNEL_VERSION=5.15 crew upgrade linuxheaders ; CREW_KERNEL_VERSION=5.15 crew build strace

  autotools_configure_options '--disable-mpers --with-libdw --disable-gcc-Werror'
end
