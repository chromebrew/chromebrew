require 'package'

class Py3_semantic_version < Package
  description 'Semantic version implements the SemVer scheme.'
  homepage 'https://github.com/rbarrois/python-semanticversion/'
  @_ver = '2.8.5'
  version @_ver
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/rbarrois/python-semanticversion.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_semantic_version/2.8.5_armv7l/py3_semantic_version-2.8.5-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_semantic_version/2.8.5_armv7l/py3_semantic_version-2.8.5-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_semantic_version/2.8.5_i686/py3_semantic_version-2.8.5-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_semantic_version/2.8.5_x86_64/py3_semantic_version-2.8.5-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'ebc85d3489343da5afc4d4813acf825323df52aac0f693f728f89100c13ee25c',
     armv7l: 'ebc85d3489343da5afc4d4813acf825323df52aac0f693f728f89100c13ee25c',
       i686: '83b1ac5f32fd508d8e2c9c0333e341cbc2bb5824a04074c19cab72d757134802',
     x86_64: '48d4d1a2df32ba2624a01a1f6670e2bf9dc2d1693fc05e893ff77e654ceb3454'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
