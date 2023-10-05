require 'buildsystems/python'

class Py3_olefile < Python
  description 'Olefile is a Python package to parse, read and write Microsoft OLE2 files.'
  homepage 'https://www.decalage.info/python/olefileio/'
  @_ver = '0.46'
  version "#{@_ver}-py3.12"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/decalage2/olefile.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_olefile/0.46-py3.12_armv7l/py3_olefile-0.46-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_olefile/0.46-py3.12_armv7l/py3_olefile-0.46-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_olefile/0.46-py3.12_i686/py3_olefile-0.46-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_olefile/0.46-py3.12_x86_64/py3_olefile-0.46-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f0ddd04f4d7ee129cff58de6321cdea56c1789f61daa62439e8d6674384ca717',
     armv7l: 'f0ddd04f4d7ee129cff58de6321cdea56c1789f61daa62439e8d6674384ca717',
       i686: '1751c5717502d897abcecffb981d5346ac8fe3105a26d3949efbddf850e5dc08',
     x86_64: '6b199cf2204839a60e5c5442b4a43a4d8db5ab9d56dc5223dfa38c39a39a24fb'
  })

  depends_on 'python3' => :build
end
