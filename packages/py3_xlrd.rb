require 'buildsystems/python'

class Py3_xlrd < Python
  description 'XLRD is a library to extract data from Microsoft Excel (tm) spreadsheet files.'
  homepage 'https://xlrd.readthedocs.io/'
  @_ver = '2.0.1'
  version "#{@_ver}-py3.12"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/python-excel/xlrd.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xlrd/2.0.1-py3.12_armv7l/py3_xlrd-2.0.1-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xlrd/2.0.1-py3.12_armv7l/py3_xlrd-2.0.1-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xlrd/2.0.1-py3.12_i686/py3_xlrd-2.0.1-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xlrd/2.0.1-py3.12_x86_64/py3_xlrd-2.0.1-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7a1ab7217475f907408d8750ed0d6413e456ef9854014c989074c011e87ef86b',
     armv7l: '7a1ab7217475f907408d8750ed0d6413e456ef9854014c989074c011e87ef86b',
       i686: '212ff9f9d31b3b55646708039daaf0f01b04a94ee18c15725b5dc92410d4071f',
     x86_64: 'eaf26e2eee9f32ccd547b0a70254655d336ede3571d873758a8c9fd7a0e2eb8d'
  })

  depends_on 'python3' => :build
end
