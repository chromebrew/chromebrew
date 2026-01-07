require 'buildsystems/autotools'

class Strace < Autotools
  description 'strace is a diagnostic, debugging and instructional userspace utility for Linux.'
  homepage 'https://strace.io/'
  version '6.18'
  license 'BSD'
  compatibility 'all'
  source_url "https://strace.io/files/#{version}/strace-#{version}.tar.xz"
  source_sha256 '0ad5dcba973a69e779650ef1cb335b12ee60716fc7326609895bd33e6d2a7325'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5788d69362290f7449236f8e8ac03cf8ac4dc2bdacbf112cae2d49b7a19f3037',
     armv7l: '5788d69362290f7449236f8e8ac03cf8ac4dc2bdacbf112cae2d49b7a19f3037',
       i686: '1337497023e3515313619a4863a4d4cd8a71259c3dc0404c954853c4ada71102',
     x86_64: '4618965949fdbf8b6aaa3a275b862f3bd86c02efc6f50d0eaad3835e46182c2c'
  })

  depends_on 'elfutils' # Needed for stack trace support
  depends_on 'glibc' # R

  # This needs to be built with linux headers 5.15 on x86_64 via
  # CREW_KERNEL_VERSION=5.15 crew upgrade linuxheaders ; CREW_KERNEL_VERSION=5.15 crew build strace

  autotools_configure_options '--disable-mpers --with-libdw --disable-gcc-Werror'
end
