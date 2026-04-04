require 'buildsystems/meson'

class Xkeyboard_config < Meson
  description 'The non-arch keyboard configuration database for X Window.'
  homepage 'https://www.freedesktop.org/wiki/Software/XKeyboardConfig/'
  version '2.47'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config.git'
  git_hashtag "xkeyboard-config-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '61fd3305c9e783d87ee8343bf5293381153741b54a402fe7597fbcebfd39ba5b',
     armv7l: '61fd3305c9e783d87ee8343bf5293381153741b54a402fe7597fbcebfd39ba5b',
     x86_64: '95da16585d9974a05b5a23ae340f7c15ce4ae30b49949257a68c3f0c8efcb504'
  })

  depends_on 'libx11' => :build
  depends_on 'libxslt' => :build
  depends_on 'py3_pytest' => :build
end
