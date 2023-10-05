require 'buildsystems/pip'

class Py3_trove_classifiers < Pip
  description 'Canonical source for classifiers on PyPI.'
  homepage 'https://github.com/pypa/trove-classifiers'
  @_ver = '2023.9.19'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_trove_classifiers/2023.9.19-py3.12_armv7l/py3_trove_classifiers-2023.9.19-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_trove_classifiers/2023.9.19-py3.12_armv7l/py3_trove_classifiers-2023.9.19-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_trove_classifiers/2023.9.19-py3.12_i686/py3_trove_classifiers-2023.9.19-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_trove_classifiers/2023.9.19-py3.12_x86_64/py3_trove_classifiers-2023.9.19-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '948476a4476c11705e493f26bbc4a96ffa7f79b8e0e44fa9eba32b77d2621b27',
     armv7l: '948476a4476c11705e493f26bbc4a96ffa7f79b8e0e44fa9eba32b77d2621b27',
       i686: '1720c4102406ca8a4c10a695afb12968637592695c2dc6da692caf5335ec5755',
     x86_64: '2a8bbd6feaf820e7c54d7c8a58c373e7c42fdcff64909e75ccf0e70bf4ba40a0'
  })

  depends_on 'python3' => :build
end
