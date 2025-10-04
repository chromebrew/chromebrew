require 'buildsystems/meson'

class Libpciaccess < Meson
  description 'Generic PCI access library'
  homepage 'https://x.org/wiki/'
  version '0.18.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libpciaccess.git'
  git_hashtag "libpciaccess-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '58f4abbb6724bcfd0ed2011c5ece919cf4501e89b7a601620143d328fe726ae5',
     armv7l: '58f4abbb6724bcfd0ed2011c5ece919cf4501e89b7a601620143d328fe726ae5',
       i686: 'c5e0e8cfff9e01d3769eee45d93e7e49c37c54f6e4a044d06ea2e420fa27fd97',
     x86_64: '5c22174c21c8776da8bd5514c4028931bbb0c775a5a857e0d339fbb2645b8026'
  })

  depends_on 'glibc' # R
end
