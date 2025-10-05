require 'package'

class Libxt < Package
  description 'X.org X Toolkit Library'
  homepage 'https://www.x.org/wiki/'
  version '1.3.1'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxt.git'
  git_hashtag "libXt-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a7ff82ccb3d878142449b1b61b4523a37c02a6341588165541159175d313dabf',
     armv7l: 'a7ff82ccb3d878142449b1b61b4523a37c02a6341588165541159175d313dabf',
     x86_64: 'c59be078d6b5120a57ee6a0ee21caea62e9f6a227855e014a3b661c3400e50f0'
  })

  depends_on 'libsm' => :build
  depends_on 'libx11' => :build
end
