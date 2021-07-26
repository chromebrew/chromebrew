require 'package'

class Py3_xmltodict < Package
  description 'XMLtoDict makes working with XML feel like you are working with JSON.'
  homepage 'https://github.com/martinblech/xmltodict/'
  @_ver = '0.12.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/martinblech/xmltodict.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xmltodict/0.12.0_armv7l/py3_xmltodict-0.12.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xmltodict/0.12.0_armv7l/py3_xmltodict-0.12.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_xmltodict/0.12.0_x86_64/py3_xmltodict-0.12.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'd2f1f67dd415be8c6ea04832d0c92a5241d2db02f33b036c89d4c04b587fb17e',
     armv7l: 'd2f1f67dd415be8c6ea04832d0c92a5241d2db02f33b036c89d4c04b587fb17e',
     x86_64: 'a71384afcde283e696cfce1754884f6b347da546ad58523929cc5600c75a5b5c'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
