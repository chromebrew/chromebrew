require 'buildsystems/meson'

class Openh264 < Meson
  description 'H.264 encoder and decoder'
  homepage 'https://www.openh264.org/'
  version '2.7.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/cisco/openh264.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e15ae4ceaa049361ecf82cb863a883ad34202bbfb60f9e1e220dd9c78b46ec3d',
     armv7l: 'e15ae4ceaa049361ecf82cb863a883ad34202bbfb60f9e1e220dd9c78b46ec3d',
       i686: '5a59e9615686797350c493d75d09b0b42e20df2c1a5d69fd03931e4695f921ea',
     x86_64: '5cfdbad16783359ddd91eb9ad1add524de466f3e165b97580c36a2ebfa9dc8ff'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'nasm' => :build

  meson_options '-Dtests=disabled'
end
