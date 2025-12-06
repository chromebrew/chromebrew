require 'buildsystems/python'

class Avocado_framework < Python
  description 'Avocado is a next generation testing framework inspired by Autotest and modern development tools such as git.'
  homepage 'https://avocado-framework.github.io/'
  version '112.0'
  license 'GPL-2 and GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/avocado-framework/avocado.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '22ff88b7d75d1566eadc58e88f1526e82e9e536e5b8e2f7937ee7e5ebf36dfc9',
     armv7l: '22ff88b7d75d1566eadc58e88f1526e82e9e536e5b8e2f7937ee7e5ebf36dfc9',
       i686: '6e2cbf94cbe2daa87e7261eee9b60b27627a315346d4e468736638c102767145',
     x86_64: '12b929bbefcf36d8cb07cc8fc658c70dd2a82aabcc0a4f872a7c3fff2d6bb34c'
  })

  depends_on 'xdg_base'
  depends_on 'xzutils'
  depends_on 'python3' => :build
end
