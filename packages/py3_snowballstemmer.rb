require 'package'

class Py3_snowballstemmer < Package
  description 'Snowball stemming library collection for Python'
  homepage 'https://snowballstem.org'
  @_ver = '2.1.0'
  version "#{@_ver}-py3.11"
  license 'BSD'
  compatibility 'all'
  source_url 'https://pypi.python.org/packages/source/s/snowballstemmer/snowballstemmer-2.1.0.tar.gz'
  source_sha256 'e997baa4f2e9139951b6f4c631bad912dfd3c792467e2f03d7239464af90e914'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_snowballstemmer/2.1.0-py3.11_armv7l/py3_snowballstemmer-2.1.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_snowballstemmer/2.1.0-py3.11_armv7l/py3_snowballstemmer-2.1.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_snowballstemmer/2.1.0-py3.11_i686/py3_snowballstemmer-2.1.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_snowballstemmer/2.1.0-py3.11_x86_64/py3_snowballstemmer-2.1.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3fee5918d80fe9bf6d1b7510469ea516f89d52813287dce07fa3d6da226506ee',
     armv7l: '3fee5918d80fe9bf6d1b7510469ea516f89d52813287dce07fa3d6da226506ee',
       i686: '2d873048ec2b09da6c7bbfcfd1dbe66511c84c4499f66000590b7dc7fc4fb066',
     x86_64: 'fb138ef4df39d93e20bb1839b30080f15587a95b31f5a908d0e68829a019ab2d'
  })

  depends_on 'py3_pystemmer'

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
