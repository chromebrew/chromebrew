require 'package'

class Py3_jeepney < Package
  description 'Jeepney is a low-level, pure Python DBus protocol wrapper.'
  homepage 'https://gitlab.com/takluyver/jeepney/'
  @_ver = '0.7.1'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/09/0d/81744e179cf3aede2d117c20c6d5b97a62ffe16b2ca5d856e068e81c7a68/jeepney-0.7.1.tar.gz'
  source_sha256 'fa9e232dfa0c498bd0b8a3a73b8d8a31978304dcef0515adc859d4e096f96f4f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jeepney/0.7.1-py3.11_armv7l/py3_jeepney-0.7.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jeepney/0.7.1-py3.11_armv7l/py3_jeepney-0.7.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jeepney/0.7.1-py3.11_i686/py3_jeepney-0.7.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_jeepney/0.7.1-py3.11_x86_64/py3_jeepney-0.7.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0da33b267a94c0e659082e35fbadcd3ca79016fe67e1303abfe471eb95226fb1',
     armv7l: '0da33b267a94c0e659082e35fbadcd3ca79016fe67e1303abfe471eb95226fb1',
       i686: 'aa5cb3b3174c93916be7db9a8b527e685379237be0a07304e65d60506554bcb5',
     x86_64: '17cac2095823723f3c87e1378f36e2e84780832d90ba60395f3b5f758e193b94'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS_NO_SVEM}"
  end
end
