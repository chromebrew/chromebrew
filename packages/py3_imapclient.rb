require 'package'

class Py3_imapclient < Package
  description 'IMAPclient is an easy-to-use, complete IMAP client library.'
  homepage 'https://imapclient.readthedocs.io/'
  @_ver = '2.2.0'
  version @_ver + '-1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/mjs/imapclient.git'
  git_hashtag @_ver

  depends_on 'py3_six'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
