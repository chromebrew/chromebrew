require 'buildsystems/python'

class Py3_click < Python
  description 'Click is a simple wrapper around optparse for powerful command line utilities.'
  homepage 'https://click.palletsprojects.com'
  @_ver = '8.1.7'
  version "#{@_ver}-py3.12"
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/pallets/click.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_click/8.1.7-py3.12_armv7l/py3_click-8.1.7-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_click/8.1.7-py3.12_armv7l/py3_click-8.1.7-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_click/8.1.7-py3.12_i686/py3_click-8.1.7-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_click/8.1.7-py3.12_x86_64/py3_click-8.1.7-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6841f11909be44ce2d1baccc66925893dab58ef5e256ad6bcd2fbdbc027c43aa',
     armv7l: '6841f11909be44ce2d1baccc66925893dab58ef5e256ad6bcd2fbdbc027c43aa',
       i686: '3670b9d3e1539843347c9846e59424684b93b1ff1ba20d54d9883a92a6643725',
     x86_64: 'c55310d8ce2c65242b08d4e4eb244b9ce5f1dfb69c73676fedc450847acc051d'
  })

  depends_on 'python3' => :build
end
