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
    aarch64: '6eec4d5d72432c69ab3ef1d5b127331cd456367b3f31e3a29f9707668d8fb757',
     armv7l: '6eec4d5d72432c69ab3ef1d5b127331cd456367b3f31e3a29f9707668d8fb757',
       i686: '8b9ac139abd5163d5f64cbd50586aef4dd5a86d4a1c6438592cafe1d2c06eabe',
     x86_64: '2390020a593445dda1a2b3fadb4f26c73f79016b6bc6cc4a9b2a395aba8765c2'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
