require 'buildsystems/python'

class Avocado_framework < Python
  description 'Avocado is a next generation testing framework inspired by Autotest and modern development tools such as git.'
  homepage 'https://avocado-framework.github.io/'
  version '113.0'
  license 'GPL-2 and GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/avocado-framework/avocado.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fce2e9d4f9ca41e6dbd21c386f23a77045ea38a7097c60fda0d2e2245e21649a',
     armv7l: 'fce2e9d4f9ca41e6dbd21c386f23a77045ea38a7097c60fda0d2e2245e21649a',
       i686: '2fd30547a3d685775e31217876ed785daa7d74a225d5deb71d789a672e38032f',
     x86_64: '988c044f3e6c99dce5a6c3216080f12df7bd76a68ffa50a684f7c8499f5200f5'
  })

  depends_on 'xdg_base'
  depends_on 'xzutils'
  depends_on 'python3' => :build
end
