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
    aarch64: '13c899b89cde0b3c30a83999333748373fa343dd49e1add72f19484a98d9a9c1',
     armv7l: '13c899b89cde0b3c30a83999333748373fa343dd49e1add72f19484a98d9a9c1',
       i686: '8d25201398c849b5993b27127e15ff3b5523c2354a543f8bb6b9423b426102be',
     x86_64: '4e4b3e936a23f145efaa878895cc8448196d6ead30d7bc0a61b3d8add4401a48'
  })

  depends_on 'glibc' # R

  meson_options '-Ddocs=false \
      -Dtests=false'
end
