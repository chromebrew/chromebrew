require 'package'

class Py3_dbfread < Package
  description 'DBFread reads DBF Files with Python.'
  homepage 'https://dbfread.readthedocs.io/'
  @_ver = '2.0.7'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/olemb/dbfread.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dbfread/2.0.7-py3.11_armv7l/py3_dbfread-2.0.7-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dbfread/2.0.7-py3.11_armv7l/py3_dbfread-2.0.7-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dbfread/2.0.7-py3.11_i686/py3_dbfread-2.0.7-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_dbfread/2.0.7-py3.11_x86_64/py3_dbfread-2.0.7-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b65ebb3937c60bf909fd6b352f17139eb778cb8be33a194be129913f46b5ec66',
     armv7l: 'b65ebb3937c60bf909fd6b352f17139eb778cb8be33a194be129913f46b5ec66',
       i686: '00d1994ab6b9d78860a79346a25769df7ac4724d97a0dc2b05a195daa6756891',
     x86_64: '8cbbe7ccf0407c72ce9838d4dec3cef7374de1db139312c977ad6a05deb5d39e'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
