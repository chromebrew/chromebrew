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
    aarch64: 'd47a891fae1c5301f65e46943d4615228506962f2961b373be1e0ecb05c61674',
     armv7l: 'd47a891fae1c5301f65e46943d4615228506962f2961b373be1e0ecb05c61674',
     x86_64: '6268a7018d07edfb6dfe97926f4c979613244f26fccd655b1990f39e8ed083cc'
  })

  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'fribidi'
  depends_on 'glibc' # R
  depends_on 'harfbuzz'
  depends_on 'nasm' => :build
end
