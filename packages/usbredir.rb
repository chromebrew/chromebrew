require 'buildsystems/meson'

class Usbredir < Meson
  description 'USB traffic redirection protocol'
  homepage 'https://www.spice-space.org/usbredir.html'
  version '0.15.0'
  license 'GPL2 LGPL2.1'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/spice/usbredir.git'
  git_hashtag "usbredir-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b02a1c24554836a2c3caaf0cd81e8b2cfb583bb289e6dfc58df9a64b54d8537c',
     armv7l: 'b02a1c24554836a2c3caaf0cd81e8b2cfb583bb289e6dfc58df9a64b54d8537c',
       i686: '2496b176ce1077771391664414f6e5ef3523495f75d0dcb711668dbbc5f1f4f1',
     x86_64: '9a6c81034c2b0c1d2ee6348a51091c5e05084cb57781f71c40f9dcb9f4254db8'
  })

  depends_on 'glib' => :executable
  depends_on 'glibc' => :library
  depends_on 'libusb' => :library

  run_tests
end
