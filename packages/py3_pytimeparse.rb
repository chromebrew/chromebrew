require 'buildsystems/python'

class Py3_pytimeparse < Python
  description 'Pytimeparse is a small Python module to parse various kinds of time expressions. '
  homepage 'https://github.com/wroberts/pytimeparse/'
  @_ver = '1.1.8'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/wroberts/pytimeparse.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytimeparse/1.1.8-py3.12_armv7l/py3_pytimeparse-1.1.8-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytimeparse/1.1.8-py3.12_armv7l/py3_pytimeparse-1.1.8-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytimeparse/1.1.8-py3.12_i686/py3_pytimeparse-1.1.8-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pytimeparse/1.1.8-py3.12_x86_64/py3_pytimeparse-1.1.8-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7ede975fd8f1a3fa7ac34ac16cc91d3117aae0b96ca14e6f1947e9c722a68593',
     armv7l: '7ede975fd8f1a3fa7ac34ac16cc91d3117aae0b96ca14e6f1947e9c722a68593',
       i686: '7969a3f238baf0f6c3608ce394e21d40278b69792a1fb2d1d88c556a80b6d09b',
     x86_64: '961a68770821a6670e86fbbb50670219e866b1a23c7bf11d1fea4023e3c4444f'
  })

  depends_on 'python3' => :build
end
