require 'buildsystems/python'

class Py3_six < Python
  description 'Six is a Python 2 and 3 compatibility library.'
  homepage 'https://six.readthedocs.io/'
  @_ver = '1.16.0'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/benjaminp/six.git'
  git_hashtag @_ver
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b5ef7eb707aaa94914ddb32ffeb0304e9748ad57e652caf6093a2c2e773e8de8',
     armv7l: 'b5ef7eb707aaa94914ddb32ffeb0304e9748ad57e652caf6093a2c2e773e8de8',
       i686: '9ae136763deaf287cb3f842024aa1a40051b81d58f6feb8f3d42c8ec4685e337',
     x86_64: 'ddb7383ccc5f776481cce40336e2e34343b5d694a78722183d56ae0c58286f1d'
  })

  depends_on 'python3' => :build
end
