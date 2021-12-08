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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_imapclient/2.2.0-1_armv7l/py3_imapclient-2.2.0-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_imapclient/2.2.0-1_armv7l/py3_imapclient-2.2.0-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_imapclient/2.2.0-1_i686/py3_imapclient-2.2.0-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_imapclient/2.2.0-1_x86_64/py3_imapclient-2.2.0-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'f742e6f24f267ca002758609c3055ba43b992f227305f1a7f8658e036c2e406f',
     armv7l: 'f742e6f24f267ca002758609c3055ba43b992f227305f1a7f8658e036c2e406f',
       i686: '41a296fbd077e4a0c260496cf5a2520a86d337b16fd10c037888436188c305a6',
     x86_64: 'be9e0af74cbc09d92effd663429657582ea794644091a26d6938446cbe1e02d9'
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
