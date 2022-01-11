require 'package'

class Py3_semantic_version < Package
  description 'Semantic version implements the SemVer scheme.'
  homepage 'https://github.com/rbarrois/python-semanticversion/'
  @_ver = '2.8.5'
  version "#{@_ver}-1"
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/rbarrois/python-semanticversion.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_semantic_version/2.8.5-1_armv7l/py3_semantic_version-2.8.5-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_semantic_version/2.8.5-1_armv7l/py3_semantic_version-2.8.5-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_semantic_version/2.8.5-1_i686/py3_semantic_version-2.8.5-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_semantic_version/2.8.5-1_x86_64/py3_semantic_version-2.8.5-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'b03fc5f7061bd1bd3ac30da7ce8bd6d62bf5afe29aa39faaa36de5e90cf652f0',
     armv7l: 'b03fc5f7061bd1bd3ac30da7ce8bd6d62bf5afe29aa39faaa36de5e90cf652f0',
       i686: '6751f63cbb407340d1fb01985478afdce1e1f14593ade65279b6ac018f6b6435',
     x86_64: 'e405ae9eb46eed11fec035bf3eceaea124abc87544ae8638a1c3a89221a29518'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
