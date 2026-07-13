require 'buildsystems/meson'

class Openh264 < Meson
  description 'H.264 encoder and decoder'
  homepage 'https://www.openh264.org/'
  version '2.6.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/cisco/openh264.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a8f6cd409bb67c0317fec6c0d4ae859223f625f65d96e8f735684fd9e0c206d8',
     armv7l: 'a8f6cd409bb67c0317fec6c0d4ae859223f625f65d96e8f735684fd9e0c206d8',
       i686: 'c30bcc97e4ac3429bd33ed29673c67a23efe365e5146fea605fe6c1edf343c98',
     x86_64: 'ce4a93fdc4c21968f946e23b34007ff216fed23705df8b653e28546df8892316'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'nasm' => :build

  meson_options '-Dtests=disabled'
end
