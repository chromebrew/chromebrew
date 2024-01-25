require 'buildsystems/autotools'

class Strace < Autotools
  description 'strace is a diagnostic, debugging and instructional userspace utility for Linux.'
  homepage 'https://strace.io/'
  version '6.6'
  license 'BSD'
  compatibility 'all'
  source_url 'https://strace.io/files/6.6/strace-6.6.tar.xz'
  source_sha256 '421b4186c06b705163e64dc85f271ebdcf67660af8667283147d5e859fc8a96c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '544bd023d12da0e88ce06dd418106fbe24a1d1657e2365c3c45e9203d14f1b99',
     armv7l: '544bd023d12da0e88ce06dd418106fbe24a1d1657e2365c3c45e9203d14f1b99',
       i686: '5a17e56927e21004e640539265bdbd2a8a22239a4213aefd0e0caa0b23f4ad9b',
     x86_64: '5f92baa820c7f9df94db506b27c82dcaf23d09ce798219637fee5dc8caf0433a'
  })

  depends_on 'elfutils' # Needed for stack trace support
  depends_on 'glibc' # R

  # This needs to be built with linux headers 4.14 on x86_64 via
  # CREW_KERNEL_VERSION=4.14 crew upgrade linuxheaders ; CREW_KERNEL_VERSION=4.14 crew build strace

  configure_options '--disable-mpers \
      --with-libdw'
end
