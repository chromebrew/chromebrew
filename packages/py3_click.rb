require 'buildsystems/pip'

class Py3_click < Pip
  description 'Click is a simple wrapper around optparse for powerful command line utilities.'
  homepage 'https://click.palletsprojects.com'
  version '8.1.7-py3.12'
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6841f11909be44ce2d1baccc66925893dab58ef5e256ad6bcd2fbdbc027c43aa',
     armv7l: '6841f11909be44ce2d1baccc66925893dab58ef5e256ad6bcd2fbdbc027c43aa',
       i686: '3670b9d3e1539843347c9846e59424684b93b1ff1ba20d54d9883a92a6643725',
     x86_64: 'c55310d8ce2c65242b08d4e4eb244b9ce5f1dfb69c73676fedc450847acc051d'
  })

  depends_on 'python3' => :build
end
