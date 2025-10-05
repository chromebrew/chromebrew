require 'buildsystems/meson'

class Fribidi < Meson
  description 'GNU FriBidi is an implementation of the Unicode Bidirectional Algorithm (bidi).'
  homepage 'https://github.com/fribidi/fribidi'
  version '1.0.16'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://github.com/fribidi/fribidi.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b74c5a5608e0640fbf5a9873a7ea0b53a3351c74ef0e38136e6fe2cca020517a',
     armv7l: 'b74c5a5608e0640fbf5a9873a7ea0b53a3351c74ef0e38136e6fe2cca020517a',
       i686: 'd26ffc24ca2ffddaf31c5e95c1904fa642d139a7cbe52900f6ab78b544e1307c',
     x86_64: '3314bbd8192a99e3e56915df475cde4c497d04b10152a7c9984edcebe844af1f'
  })

  depends_on 'glibc' # R

  meson_options '-Ddocs=false \
      -Dtests=false'
end
