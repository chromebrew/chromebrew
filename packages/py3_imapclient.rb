require 'package'

class Py3_imapclient < Package
  description 'IMAPclient is an easy-to-use, complete IMAP client library.'
  homepage 'https://imapclient.readthedocs.io/'
  @_ver = '2.2.0'
  version "#{@_ver}-py3.11"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/mjs/imapclient.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_imapclient/2.2.0-py3.11_armv7l/py3_imapclient-2.2.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_imapclient/2.2.0-py3.11_armv7l/py3_imapclient-2.2.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_imapclient/2.2.0-py3.11_i686/py3_imapclient-2.2.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_imapclient/2.2.0-py3.11_x86_64/py3_imapclient-2.2.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a0b0bbbb01ef36f929431ac9a9fe1477d6894bc009ebb3663797ca55b1b04cbe',
     armv7l: 'a0b0bbbb01ef36f929431ac9a9fe1477d6894bc009ebb3663797ca55b1b04cbe',
       i686: '9d846c07739260da24b35ce9f79ead98bcce577c1ba35ec9578174beafdcb19c',
     x86_64: '6f8ae1871153b0437b687eab641e3a326d5b9bbf9f3fe86e4b7097ef57111a50'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
