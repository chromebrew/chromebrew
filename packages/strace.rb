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

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/strace/6.6_armv7l/strace-6.6-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/strace/6.6_armv7l/strace-6.6-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/strace/6.6_i686/strace-6.6-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/strace/6.6_x86_64/strace-6.6-chromeos-x86_64.tar.zst'
  })
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
