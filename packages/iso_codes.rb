require 'buildsystems/meson'

class Iso_codes < Meson
  description 'Provides lists of various ISO standards (countries, languages, language scripts, and currency names)'
  homepage 'https://salsa.debian.org/iso-codes-team/iso-codes'
  version '4.20.1'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://salsa.debian.org/iso-codes-team/iso-codes.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd2b3138df48366fef39d75ffd144f15faf2bc127d0d2b36e86ff9b9875856139',
     armv7l: 'd2b3138df48366fef39d75ffd144f15faf2bc127d0d2b36e86ff9b9875856139',
       i686: '88add42dc3e09877ab6683d6b49ce75b891de836e6b1dfa222fee7ab3d1cd720',
     x86_64: '21f98f1d2e699f0ff5504574b8fdd5a5c5826b23cc5a4f9fd0f270288f8a6eef'
  })
end
