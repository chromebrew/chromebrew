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
    aarch64: 'b6b897283186bd9d80be0e856b83e429dbde5ffcc8ed79835ab8e3a08843d61a',
     armv7l: 'b6b897283186bd9d80be0e856b83e429dbde5ffcc8ed79835ab8e3a08843d61a',
       i686: '432bf6c97b5ac415dfaca2cd8d24289d9e79dfa79495dc5fd1eacb22dfac4a5c',
     x86_64: '620e9c48c5d2dcff92e0f45774023b2013ccdec4f066ee953ab1cd26d00208ed'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
