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
    aarch64: 'f09d352f9173eea42ef7c3db6b45ad7cfc39f7d1d3246f29e69705b76989e97d',
     armv7l: 'f09d352f9173eea42ef7c3db6b45ad7cfc39f7d1d3246f29e69705b76989e97d',
       i686: 'abe1a2183da52fb0b8f52e530c9ace2dc7230bbca4c5e52313d362427b3fe8bb',
     x86_64: '0ac5d57c8347e7ab815a7eafd7f1fbefd7971b2d68433d92c69344bcc035fbbf'
  })

  depends_on 'elfutils' # Needed for stack trace support
  depends_on 'glibc' # R

  # This needs to be built with linux headers 5.15 on x86_64 via
  # CREW_KERNEL_VERSION=5.15 crew upgrade linuxheaders ; CREW_KERNEL_VERSION=5.15 crew build strace

  autotools_configure_options '--disable-mpers --with-libdw --disable-gcc-Werror'
end
