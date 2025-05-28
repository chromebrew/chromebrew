require 'buildsystems/autotools'

class Strace < Autotools
  description 'strace is a diagnostic, debugging and instructional userspace utility for Linux.'
  homepage 'https://strace.io/'
  version '6.12'
  license 'BSD'
  compatibility 'all'
  source_url "https://strace.io/files/#{version}/strace-#{version}.tar.xz"
  source_sha256 'c47da93be45b6055f4dc741d7f20efaf50ca10160a5b100c109b294fd9c0bdfe'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3267353f1f68179404b4f02f76e699b2dd4e374f8956cccf03f603cff669ad09',
     armv7l: '3267353f1f68179404b4f02f76e699b2dd4e374f8956cccf03f603cff669ad09',
       i686: '6594711e253b39619dad8b82303fb18b4e4ae2063afbc59b1b43a7dd71bee9c5',
     x86_64: '4364b3979ab0a0dacf66137a1a42d0cb807a56bab29450846130b8d9eaf69aa1'
  })

  depends_on 'elfutils' # Needed for stack trace support
  depends_on 'glibc' # R

  # This needs to be built with linux headers 5.15 on x86_64 via
  # CREW_KERNEL_VERSION=5.15 crew upgrade linuxheaders ; CREW_KERNEL_VERSION=5.15 crew build strace

  autotools_configure_options '--disable-mpers --with-libdw --disable-gcc-Werror'
end
