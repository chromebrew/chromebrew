require 'buildsystems/meson'

class Xkeyboard_config < Meson
  description 'The non-arch keyboard configuration database for X Window.'
  homepage 'https://www.freedesktop.org/wiki/Software/XKeyboardConfig/'
  compatibility 'aarch64 armv7l x86_64'
  version '2.46'
  license 'MIT'
  source_url 'https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config.git'
  git_hashtag "xkeyboard-config-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eae7e1d93e5ad45040b4f98f641d9710c5815bc753fabb0e51d781eeb45785bc',
     armv7l: 'eae7e1d93e5ad45040b4f98f641d9710c5815bc753fabb0e51d781eeb45785bc',
     x86_64: 'a3d3467cbc60baa18a8f41585103ad440cff1461c835b895c82e5f51f4f34382'
  })

  depends_on 'libx11' => :build
end
