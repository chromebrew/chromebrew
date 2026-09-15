require 'buildsystems/meson'

class Yaru < Meson
  description 'Yaru default ubuntu theme'
  homepage 'https://github.com/ubuntu/yaru'
  version '26.10.3'
  license 'GPL-3 and CC-BY-SA-4.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/ubuntu/yaru.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bae79e1bddaa3b3565c38b21af178f8ae6f4a46c72077dc36e98349be50051c5',
     armv7l: 'bae79e1bddaa3b3565c38b21af178f8ae6f4a46c72077dc36e98349be50051c5',
     x86_64: '098ac8895f5ba6601abfd2b40210203a7494a4757cf3212f4a2ad946c564c4b1'
  })

  depends_on 'sassc'

  meson_options ' -Dubuntu-unity=true'
end
