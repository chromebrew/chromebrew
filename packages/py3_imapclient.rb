require 'package'

class Py3_imapclient < Package
  description 'IMAPclient is an easy-to-use, complete IMAP client library.'
  homepage 'https://imapclient.readthedocs.io/'
  @_ver = '2.2.0'
  version "#{@_ver}-1"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/mjs/imapclient.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_imapclient/2.2.0_armv7l/py3_imapclient-2.2.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_imapclient/2.2.0_armv7l/py3_imapclient-2.2.0-chromeos-armv7l.tpxz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_imapclient/2.2.0-1_i686/py3_imapclient-2.2.0-1-chromeos-i686.tpxz',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_imapclient/2.2.0-1_x86_64/py3_imapclient-2.2.0-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '26ba0231d3a994da411ef64e6fbee4676be0f66a5fa66d5412ee13a0c7e78dd6',
     armv7l: '26ba0231d3a994da411ef64e6fbee4676be0f66a5fa66d5412ee13a0c7e78dd6',
    i686: '40a4b96973fc1e4b6fc51066b984292e84ea0c8988b08df9c2c8b84b6f2338ad',
  x86_64: '43ef4e74eb35722a950e077160a776cc74d35c243b0f104c799166a55a19ee4f'
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
