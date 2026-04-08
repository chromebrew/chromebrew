require 'buildsystems/meson'

class Xkeyboard_config < Meson
  description 'The non-arch keyboard configuration database for X Window.'
  homepage 'https://www.freedesktop.org/wiki/Software/XKeyboardConfig/'
  version '2.47-1'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config.git'
  git_hashtag "xkeyboard-config-#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f96d53d29a55c9f0b46cb1e1e2891dc6d7ce46f6c0be8fe91f7179a6eaf13a39',
     armv7l: 'f96d53d29a55c9f0b46cb1e1e2891dc6d7ce46f6c0be8fe91f7179a6eaf13a39',
     x86_64: 'a8ec9dad6dc2a7611981b01b4beee2b7c03e021f0cb774d14a89a846bbe2f056'
  })

  depends_on 'libx11' => :build
  depends_on 'libxslt' => :build
  depends_on 'py3_pytest' => :build
end
