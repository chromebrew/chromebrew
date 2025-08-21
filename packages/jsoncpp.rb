require 'buildsystems/meson'

class Jsoncpp < Meson
  description 'A C++ library for interacting with JSON.'
  homepage 'https://github.com/open-source-parsers/jsoncpp'
  version '1.9.6'
  license 'MIT, public-domain'
  compatibility 'all'
  source_url 'https://github.com/open-source-parsers/jsoncpp.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '71fb94fdc4876273871a39cac3dbb84e0695a27aa307acb2601f227c374313bb',
     armv7l: '71fb94fdc4876273871a39cac3dbb84e0695a27aa307acb2601f227c374313bb',
       i686: '45cfb7ba6a35022261b262b813a99654046a08d4ccc67d496465b72337157b7a',
     x86_64: '5496a7bb46dd54ee680ef70955f1259cf3c0173a2f8bf8c518458ecce5cb1f9e'
  })
end
