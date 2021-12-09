require 'package'

class Py3_jmespath < Package
  description 'JMESPath is a query language for JSON.'
  homepage 'https://jmespath.org/'
  @_ver = '0.10.0'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/jmespath/jmespath.py.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jmespath/0.10.0-1_armv7l/py3_jmespath-0.10.0-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jmespath/0.10.0-1_armv7l/py3_jmespath-0.10.0-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jmespath/0.10.0-1_i686/py3_jmespath-0.10.0-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jmespath/0.10.0-1_x86_64/py3_jmespath-0.10.0-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'a69678814a7638dc21174574f61fd0c5130741ebe1856dfc9d13b10dc3d48eaf',
     armv7l: 'a69678814a7638dc21174574f61fd0c5130741ebe1856dfc9d13b10dc3d48eaf',
       i686: '6c81f0ca4f3c11e78a94e65ee9c6b2722b71ff8c8554fbbbd565fc89e4886933',
     x86_64: '36b600ebd4ba2a77828d6a2ec409bec40286b993a56bb2a5fe44b090fb7a9482'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
