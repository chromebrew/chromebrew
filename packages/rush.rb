require 'buildsystems/autotools'

class Rush < Autotools
  description 'GNU Rush is a Restricted User Shell.'
  homepage 'https://www.gnu.org/software/rush/'
  version '2.4'
  license 'GPL-3'
  compatibility 'all'
  source_url 'http://git.gnu.org.ua/rush.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
       i686: '1c891be6b48584f7579213b542c76a6df6b2ef790814273fd8c84df8309ea5b0',
     x86_64: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  })

  depends_on 'glibc' # R

  run_tests
end
