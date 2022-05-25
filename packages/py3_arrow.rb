require 'buildsystems/python'

class Py3_arrow < Python
  description 'Arrow is a Python library that offers a sensible and human-friendly approach to creating, manipulating, formatting and converting dates, times and timestamps.'
  homepage 'https://arrow.readthedocs.io/'
  @_ver = '1.3.0'
  version "#{@_ver}-py3.12"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/arrow-py/arrow.git'
  git_hashtag @_ver
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_arrow/1.3.0-py3.12_armv7l/py3_arrow-1.3.0-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_arrow/1.3.0-py3.12_armv7l/py3_arrow-1.3.0-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_arrow/1.3.0-py3.12_i686/py3_arrow-1.3.0-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_arrow/1.3.0-py3.12_x86_64/py3_arrow-1.3.0-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '54f24a907e27fce81b2ccdd833d0c495a8d30a6ce6a92f208a7756105b69b91e',
     armv7l: '54f24a907e27fce81b2ccdd833d0c495a8d30a6ce6a92f208a7756105b69b91e',
       i686: 'b137a093d99df2697cc672e330a781cf54d78ede22ba8685696a602742cc5aa1',
     x86_64: '560c75d48cb0d8cbdbf55aa835fc245b722eeb36cf65a72cef19d4acbbe60abd'
  })

  depends_on 'py3_dateutil'
  depends_on 'python3' => :build
end
