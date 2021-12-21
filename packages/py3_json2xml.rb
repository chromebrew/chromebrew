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
    aarch64: '3b20a3b6b281900888fa7c232c8f57a20cc7af36e66ec92c183bd900b5c25172',
     armv7l: '3b20a3b6b281900888fa7c232c8f57a20cc7af36e66ec92c183bd900b5c25172',
       i686: '3528407115c0602f6d881d782500714426ede5994ae0b940a61d98f3612f7815',
     x86_64: 'cfe83ee7e6ef6208facb755c1c80125b1db4fafef0a5993f78ea6841d2964b26'
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
