require 'buildsystems/cmake'

class Editorconfig_core_c < CMake
  description 'EditorConfig core code written in C for use by plugins supporting EditorConfig parsing'
  homepage 'https://github.com/editorconfig/editorconfig-core-c'
  version '0.12.10'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/editorconfig/editorconfig-core-c.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e11a40cf379fbcdd7da6aa7183c097214909c6375bb609587a07fbeb55dd4eb3',
     armv7l: 'e11a40cf379fbcdd7da6aa7183c097214909c6375bb609587a07fbeb55dd4eb3',
       i686: 'b6f86925b01a0b25ff7fbac61fb6ca683e519ba262daf7a9a2389d7e79810a74',
     x86_64: 'eb1ad56f799f7f276aa7aef8a5d589a99b9f3469879eb79e2846f5c95dae22bd'
  })

  depends_on 'pcre2' # R
  depends_on 'glibc' # R
end
