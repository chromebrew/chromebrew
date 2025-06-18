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
    aarch64: '30d4606dd3fe8a983451479a6094daea97f26df503b7d106dca57ac7c67e9670',
     armv7l: '30d4606dd3fe8a983451479a6094daea97f26df503b7d106dca57ac7c67e9670',
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
