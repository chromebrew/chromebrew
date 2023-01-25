require 'package'

class Py3_jmespath < Package
  description 'JMESPath is a query language for JSON.'
  homepage 'https://jmespath.org/'
  @_ver = '0.10.0'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/jmespath/jmespath.py.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jmespath/0.10.0-py3.11_armv7l/py3_jmespath-0.10.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jmespath/0.10.0-py3.11_armv7l/py3_jmespath-0.10.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jmespath/0.10.0-py3.11_i686/py3_jmespath-0.10.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jmespath/0.10.0-py3.11_x86_64/py3_jmespath-0.10.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '224d411884c8f7573f62a83dbee130d372f25ce2e50a43af864542376f59fcc7',
     armv7l: '224d411884c8f7573f62a83dbee130d372f25ce2e50a43af864542376f59fcc7',
       i686: '950e54017152ba88fe14acd82527a734725bdcb84c0ab6150770153591ef296f',
     x86_64: 'cf6fabd0b3335419b092a37fae5d808c21b20581a8962604fe8fb5edeb173b91'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
