require 'buildsystems/python'

class Py3_pep517 < Python
  description 'Python PEP517 is an API to call PEP 517 hooks for building Python packages '
  homepage 'https://pep517.readthedocs.io/'
  @_ver = '1.0.0'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pyproject-hooks.git'
  git_hashtag "v#{@_ver}"
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pep517/1.0.0-py3.12_armv7l/py3_pep517-1.0.0-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pep517/1.0.0-py3.12_armv7l/py3_pep517-1.0.0-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pep517/1.0.0-py3.12_i686/py3_pep517-1.0.0-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pep517/1.0.0-py3.12_x86_64/py3_pep517-1.0.0-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '62cf60f52ab472c3818994551df107cacf3ed117385bc6424a1b983284db92fb',
     armv7l: '62cf60f52ab472c3818994551df107cacf3ed117385bc6424a1b983284db92fb',
       i686: '4b405040cd88a26963f2593471afeec33b84549c66e019ef824ffe9995baf497',
     x86_64: 'de410a43722cbac887a4a4a0b5f7a6bb311b059ff6462930cb795da07f0217c3'
  })

  depends_on 'python3'
  depends_on 'py3_tomli'
end
