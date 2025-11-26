require 'buildsystems/autotools'

class Libass < Autotools
  description 'A portable subtitle renderer for the ASS/SSA (Advanced Substation Alpha/Substation Alpha) subtitle format.'
  homepage 'https://github.com/libass/libass'
  version '0.17.4'
  license 'ISC'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/libass/libass.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     x86_64: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  })

  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'fribidi'
  depends_on 'harfbuzz'
  depends_on 'nasm' => :build
end
