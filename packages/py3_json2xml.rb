require 'package'

class Py3_json2xml < Package
  description 'json to xml converter'
  homepage 'https://json2xml.readthedocs.io/'
  @_ver = '3.6.0'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/vinitkumar/json2xml.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_json2xml/3.6.0_armv7l/py3_json2xml-3.6.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_json2xml/3.6.0_armv7l/py3_json2xml-3.6.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_json2xml/3.6.0_x86_64/py3_json2xml-3.6.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'ebaf5d827ea6d9683d36b6db16f04a2de05d0fd1e63b2b2c0d82602ede6b9b46',
     armv7l: 'ebaf5d827ea6d9683d36b6db16f04a2de05d0fd1e63b2b2c0d82602ede6b9b46',
     x86_64: '13e41d07e2939271ba4d3cd2ad458cfa84490c3c57fa8da3328031f91d954af3'
  })

  depends_on 'py3_requests'
  depends_on 'py3_xmltodict'
  depends_on 'py3_dicttoxml'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
