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

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pep517/1.0.0-py3.12_armv7l/py3_pep517-1.0.0-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pep517/1.0.0-py3.12_armv7l/py3_pep517-1.0.0-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pep517/1.0.0-py3.12_i686/py3_pep517-1.0.0-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pep517/1.0.0-py3.12_x86_64/py3_pep517-1.0.0-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a01cd591a7c735c256b6b7415cebc5fd73bce4d6aaa460d609deb94629ef59c6',
     armv7l: 'a01cd591a7c735c256b6b7415cebc5fd73bce4d6aaa460d609deb94629ef59c6',
       i686: 'f7f250a9f51602cc511a859e532b3ea4f5e72b0671ff0c329c6e24371bb4c462',
     x86_64: 'f1087c011dbb2d74864e1c96271a3ad0c3ce41e296eee722e7b359ac355b7680'
  })

  depends_on 'python3'
  depends_on 'py3_tomli'
end
