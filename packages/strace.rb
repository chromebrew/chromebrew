require 'buildsystems/autotools'

class Strace < Autotools
  description 'strace is a diagnostic, debugging and instructional userspace utility for Linux.'
  homepage 'https://strace.io/'
  version '6.7'
  license 'BSD'
  compatibility 'all'
  source_url 'https://strace.io/files/6.7/strace-6.7.tar.xz'
  source_sha256 '2090201e1a3ff32846f4fe421c1163b15f440bb38e31355d09f82d3949922af7'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '17d17894e2e6310672586b7d1f542490d8d000f78ed49117c79145d318beb241',
     armv7l: '17d17894e2e6310672586b7d1f542490d8d000f78ed49117c79145d318beb241',
       i686: 'e781f0a6c053e44bc1afa18d4a576754ff147dbb6c66cf020181e3ef368b3d71',
     x86_64: '3728df0a5f17fb34f79fc8011976f7f1052700238897b05dbd785e918eeca62f'
  })

  depends_on 'elfutils' # Needed for stack trace support
  depends_on 'glibc' # R

  # This needs to be built with linux headers 4.14 on x86_64 via
  # CREW_KERNEL_VERSION=5.15 crew upgrade linuxheaders ; CREW_KERNEL_VERSION=5.15 crew build strace

  configure_options '--disable-mpers \
      --with-libdw'
end
