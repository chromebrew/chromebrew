require 'buildsystems/python'

class Py3_wcwidth < Python
  description 'WCWidth measures the displayed width of unicode strings in a terminal.'
  homepage 'https://github.com/jquast/wcwidth/'
  @_ver = '0.2.8'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/jquast/wcwidth.git'
  git_hashtag @_ver
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wcwidth/0.2.8-py3.12_armv7l/py3_wcwidth-0.2.8-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wcwidth/0.2.8-py3.12_armv7l/py3_wcwidth-0.2.8-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wcwidth/0.2.8-py3.12_i686/py3_wcwidth-0.2.8-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wcwidth/0.2.8-py3.12_x86_64/py3_wcwidth-0.2.8-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'cd6136b406d1a8f99f57f3d3e236a5481a2b5d8f49c3df8d6817eb647d492230',
     armv7l: 'cd6136b406d1a8f99f57f3d3e236a5481a2b5d8f49c3df8d6817eb647d492230',
       i686: '858e055dc4e449a6747eadce697b25251ece8417f4b5d55fd5c41d800555b85f',
     x86_64: '9ec0afbf22c0543d6501b121795fdd33c39aca3bf503b40578002bc448d4a588'
  })

  depends_on 'python3' => :build
end
