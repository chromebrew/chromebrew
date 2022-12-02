require 'package'

class Py3_json2xml < Package
  description 'json to xml converter'
  homepage 'https://json2xml.readthedocs.io/'
  @_ver = '3.8.0'
  version "#{@_ver}-py3.11"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/vinitkumar/json2xml.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_json2xml/3.8.0-py3.11_armv7l/py3_json2xml-3.8.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_json2xml/3.8.0-py3.11_armv7l/py3_json2xml-3.8.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_json2xml/3.8.0-py3.11_i686/py3_json2xml-3.8.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_json2xml/3.8.0-py3.11_x86_64/py3_json2xml-3.8.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ace1ef2ec960489a1449fa22e90f858f1e005b575d946e8495d490c8bccb6ba0',
     armv7l: 'ace1ef2ec960489a1449fa22e90f858f1e005b575d946e8495d490c8bccb6ba0',
       i686: '9c69ba1f5b31db25cf5e034b8691bb51e8c0b89aa4f262f5811668218c9e12e0',
     x86_64: '04cea24f36031ac2b194c4f341d5c0f9c9bb649456f1172ad0e432b274bfb065'
  })

  depends_on 'py3_requests'
  depends_on 'py3_xmltodict'
  depends_on 'py3_dicttoxml'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
