require 'buildsystems/pip'

class Py3_semantic_version < Pip
  description 'Semantic version implements the SemVer scheme.'
  homepage 'https://github.com/rbarrois/python-semanticversion/'
  @_ver = '2.10.0'
  version "#{@_ver}-py3.12"
  license 'BSD-2'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_semantic_version/2.10.0-py3.12_armv7l/py3_semantic_version-2.10.0-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_semantic_version/2.10.0-py3.12_armv7l/py3_semantic_version-2.10.0-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_semantic_version/2.10.0-py3.12_i686/py3_semantic_version-2.10.0-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_semantic_version/2.10.0-py3.12_x86_64/py3_semantic_version-2.10.0-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '396d1ff3ea7032bd7620d174cb861a349080b7393937287829685f80e3863a8d',
     armv7l: '396d1ff3ea7032bd7620d174cb861a349080b7393937287829685f80e3863a8d',
       i686: '429501e5a3029aede475747ab8e784a12b5e8948ef835f04f8f7dea78d80a5a0',
     x86_64: 'c327d7e644c462a6b7757c070eb00d7ed0f97d4e77928bcac2c3cc8e80c47981'
  })

  depends_on 'python3' => :build
end
