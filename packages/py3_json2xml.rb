require 'package'

class Py3_json2xml < Package
  description 'json to xml converter'
  homepage 'https://json2xml.readthedocs.io/'
  @_ver = '3.8.0'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/vinitkumar/json2xml.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_json2xml/3.8.0_armv7l/py3_json2xml-3.8.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_json2xml/3.8.0_armv7l/py3_json2xml-3.8.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_json2xml/3.8.0_i686/py3_json2xml-3.8.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_json2xml/3.8.0_x86_64/py3_json2xml-3.8.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '1ef588aab7ce1dd1d9359d52aacde2aa5a157b456a93891d3b1dcc556f729d1d',
     armv7l: '1ef588aab7ce1dd1d9359d52aacde2aa5a157b456a93891d3b1dcc556f729d1d',
       i686: 'eb80f33fb875d05d87a7f822c277425602c9ef789ce462d1f175f0d4e261cc40',
     x86_64: '4e55c8ba7944e78cbc9e58019d9ccc1409133c9e221b68ba885036f30838042a'
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
