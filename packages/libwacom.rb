require 'buildsystems/meson'

class Libwacom < Meson
  description 'libwacom is a wrapper library for evdev devices.'
  homepage 'https://github.com/linuxwacom/libwacom'
  version '2.16.1'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/linuxwacom/libwacom.git'
  git_hashtag "libwacom-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f7c3aa3b6f959b942e83ac4906ec57e70d1af52db9d9896684a3be2451353f65',
     armv7l: 'f7c3aa3b6f959b942e83ac4906ec57e70d1af52db9d9896684a3be2451353f65',
     x86_64: 'be1cfb9fa6642b601c0de5526a24098be60150071459357d2f69f9f27d62cdd8'
  })

  depends_on 'libgudev'
  depends_on 'eudev'
  depends_on 'libevdev'
  depends_on 'py3_libevdev' => :build
  depends_on 'py3_pyudev' => :build
  depends_on 'py3_pytest' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R

  meson_options '-Dtests=disabled'
end
