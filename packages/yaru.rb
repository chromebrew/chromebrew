require 'buildsystems/meson'

class Yaru < Meson
  description 'Yaru default ubuntu theme'
  homepage 'https://github.com/ubuntu/yaru'
  version '25.10.2-0ubuntu1'
  license 'GPL-3 and CC-BY-SA-4.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/ubuntu/yaru.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '41ab422c7136ed3f8c6c959687a7808615624857d885a58cc366bf3aeafcacb8',
     armv7l: '41ab422c7136ed3f8c6c959687a7808615624857d885a58cc366bf3aeafcacb8',
     x86_64: 'dc2b68a4a1c4a0c5a2efe8ee180e5d773629e61edeaa543bc7ef45bc1b91348c'
  })

  depends_on 'sassc'

  meson_options ' -Dubuntu-unity=true'
end
