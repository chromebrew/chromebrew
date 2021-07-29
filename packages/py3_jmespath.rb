require 'package'

class Py3_jmespath < Package
  description 'JMESPath is a query language for JSON.'
  homepage 'https://jmespath.org/'
  @_ver = '0.10.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/jmespath/jmespath.py.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jmespath/0.10.0_armv7l/py3_jmespath-0.10.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jmespath/0.10.0_armv7l/py3_jmespath-0.10.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jmespath/0.10.0_x86_64/py3_jmespath-0.10.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '0fc01341a03a02daad06ef2bf3e82c947964a2b9e048890e7f638712bea1d072',
     armv7l: '0fc01341a03a02daad06ef2bf3e82c947964a2b9e048890e7f638712bea1d072',
     x86_64: 'bfab11e20104c918092dc31029083424a461207f28093e9fc5873fb3f791ca52'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
