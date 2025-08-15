require 'buildsystems/autotools'

class Xcb_util_keysyms < Autotools
  description 'The xcb-util-keysyms package contains a library for handling standard X key constants and conversion to/from keycodes.'
  homepage 'https://xcb.freedesktop.org/'
  version '0.4.1'
  compatibility 'all'
  license 'MIT-with-advertising'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxcb-keysyms.git'
  git_hashtag "xcb-util-keysyms-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dc00e514a928a196fde0c698810b2f6b63b83e29e680d489d50c049aafb8ad18',
     armv7l: 'dc00e514a928a196fde0c698810b2f6b63b83e29e680d489d50c049aafb8ad18',
       i686: 'e0564edbf2534623934a840c8500b7df660b25f91196d548f9c7c199a0196793',
     x86_64: 'a8905397714291fcfd8d8efd81fcd17dea59e8ae41a83da850754c2b16ed4737'
  })

  depends_on 'glibc' # R
  depends_on 'libbsd' # R

end
