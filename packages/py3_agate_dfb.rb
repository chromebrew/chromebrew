require 'buildsystems/python'

class Py3_agate_dfb < Python
  description 'Agate-dbf adds read support for DBF files to agate.'
  homepage 'https://agate-dbf.readthedocs.org/'
  @_ver = '0.2.2'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/wireservice/agate-dbf.git'
  git_hashtag @_ver
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8e4ac34981be8be2127482517337d2bf4e70b06902dc9f91c0d91a49e2623673',
     armv7l: '8e4ac34981be8be2127482517337d2bf4e70b06902dc9f91c0d91a49e2623673',
       i686: '9582e1f100f7b44022f653d2c796f56796bf3b33d2c5c57d44567d963146360f',
     x86_64: '43ab7af0fcc37528b4b649a2e50c49d8177c8be7420062a9219f96397036ffc0'
  })

  depends_on 'py3_dbfread'
  depends_on 'py3_agate'
  depends_on 'python3' => :build
end
