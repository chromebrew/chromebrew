require 'buildsystems/meson'

class Ots < Meson
  description 'Sanitizer for OpenType'
  homepage 'https://github.com/khaledhosny/ots'
  version '9.1.0'
  license 'BSD 3-Clause'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/khaledhosny/ots.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '00026f763df0e444828113ee74e0e5d53185069f2b21d07918dadfc2e4fb9e49',
     armv7l: '00026f763df0e444828113ee74e0e5d53185069f2b21d07918dadfc2e4fb9e49',
     x86_64: 'c481f4510b09af6d6a0db529c614a8ff57036f54f1f1a71e19e43085e36699e6'
  })

  depends_on 'gtest'
  depends_on 'freetype'
  depends_on 'woff2'

  run_tests
end
