require 'buildsystems/meson'

class Libxdamage < Meson
  description 'library for the X window system'
  homepage 'https://x.org/wiki/'
  version '1.1.6-1319ae5'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxdamage.git'
  git_hashtag '1319ae5cfbde5b75e23383baa5e00cc23513448c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aa014235465fda5eec08c134e335d8f20b3ecdb9e78d333f9a377c535b6078f6',
     armv7l: 'aa014235465fda5eec08c134e335d8f20b3ecdb9e78d333f9a377c535b6078f6',
     x86_64: '1782de63b4e5ba46ef8d5389bc5dd4bd8ae72a6cf38cd18f8b6d68af227ea5b9'
  })

  depends_on 'glibc' # R
  depends_on 'libx11' # R
  depends_on 'libxfixes' => :build
end
