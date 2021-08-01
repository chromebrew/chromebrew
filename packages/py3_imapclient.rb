require 'package'

class Py3_imapclient < Package
  description 'IMAPclient is an easy-to-use, complete IMAP client library.'
  homepage 'https://imapclient.readthedocs.io/'
  @_ver = '2.2.0'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/mjs/imapclient.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_imapclient/2.2.0_armv7l/py3_imapclient-2.2.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_imapclient/2.2.0_armv7l/py3_imapclient-2.2.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_imapclient/2.2.0_x86_64/py3_imapclient-2.2.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '26ba0231d3a994da411ef64e6fbee4676be0f66a5fa66d5412ee13a0c7e78dd6',
     armv7l: '26ba0231d3a994da411ef64e6fbee4676be0f66a5fa66d5412ee13a0c7e78dd6',
     x86_64: '02bc417b206a0881fb13c6804b02281168eca1688932f944a4a5355fb1809528'
  })

  depends_on 'py3_six'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
