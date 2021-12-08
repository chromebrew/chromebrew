require 'package'

class Py3_pyasn1 < Package
  description 'PyASN.1 is a generic ASN.1 library for Python'
  homepage 'https://github.com/etingof/pyasn1/'
  @_ver = '0.4.8'
  version "#{@_ver}-1"
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/etingof/pyasn1.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyasn1/0.4.8-1_armv7l/py3_pyasn1-0.4.8-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyasn1/0.4.8-1_armv7l/py3_pyasn1-0.4.8-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyasn1/0.4.8-1_i686/py3_pyasn1-0.4.8-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyasn1/0.4.8-1_x86_64/py3_pyasn1-0.4.8-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'd9ca4fe715b2d51dfbc819568f12df82edc6770b2b8f3556304cdee267ca5cfc',
     armv7l: 'd9ca4fe715b2d51dfbc819568f12df82edc6770b2b8f3556304cdee267ca5cfc',
       i686: 'b1c488ddb0a3c2b4055ff9efc4e72b9e4ebd9a5bcfa513c4cd24d1a03c1f6208',
     x86_64: '9be6d5cb186073d9c04adc800d49ec02251003e59e07fdff65475ef6f4be1be9'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
