require 'buildsystems/python'

class Py3_leather < Python
  description 'Leather is a fast, approximate chart generator in Python.'
  homepage 'https://leather.readthedocs.io/'
  @_ver = '0.3.4'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/wireservice/leather.git'
  git_hashtag @_ver
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e97384f56288da6c88a4002c1f47e832551e4295f7e3eeb5c8e721a0aed70e2c',
     armv7l: 'e97384f56288da6c88a4002c1f47e832551e4295f7e3eeb5c8e721a0aed70e2c',
       i686: '289f5072c1d82e07fa812fc08437fa54577989148036295030dab5eee4f1d928',
     x86_64: '88fbb3488cd5e8e0e8253c3f9c8fc004dc68051009be3f54f4c9e26ddac17747'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :build
end
