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
