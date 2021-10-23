require 'package'

class Py3_snowballstemmer < Package
  description 'Snowball stemming library collection for Python'
  homepage 'https://snowballstem.org'
  @_ver = '2.1.0'
  version "#{@_ver}-1"
  license 'BSD'
  compatibility 'all'
  source_url 'https://pypi.python.org/packages/source/s/snowballstemmer/snowballstemmer-2.1.0.tar.gz'
  source_sha256 'e997baa4f2e9139951b6f4c631bad912dfd3c792467e2f03d7239464af90e914'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_snowballstemmer/2.1.0-1_armv7l/py3_snowballstemmer-2.1.0-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_snowballstemmer/2.1.0-1_armv7l/py3_snowballstemmer-2.1.0-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_snowballstemmer/2.1.0-1_i686/py3_snowballstemmer-2.1.0-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_snowballstemmer/2.1.0-1_x86_64/py3_snowballstemmer-2.1.0-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'b49e93f44e74a576b5996824ee9a2ab7e5feffc7541c549b3900f2d974bfbfdc',
     armv7l: 'b49e93f44e74a576b5996824ee9a2ab7e5feffc7541c549b3900f2d974bfbfdc',
       i686: '7d0c1302de8c6ec8a3bfaba05a2096094d1d3a312524cdc15a97f4a4ffd96f05',
     x86_64: '1a12046dcf38289daf7eed44d6ddcae3d2d1ca1899db276f7eff7560cb509cee'
  })

  depends_on 'py3_pystemmer'

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
