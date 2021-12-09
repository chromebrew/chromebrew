require 'package'

class Py3_importlib_metadata < Package
  description 'Importlib metadata reads metadata from Python packages.'
  homepage 'https://github.com/python/importlib_metadata/'
  @_ver = '4.8.1'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/python/importlib_metadata.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_importlib_metadata/4.8.1_armv7l/py3_importlib_metadata-4.8.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_importlib_metadata/4.8.1_armv7l/py3_importlib_metadata-4.8.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_importlib_metadata/4.8.1_i686/py3_importlib_metadata-4.8.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_importlib_metadata/4.8.1_x86_64/py3_importlib_metadata-4.8.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '6139b68179532986690383b18389c8c6932f754a002ad90ce58aa9c58231c065',
     armv7l: '6139b68179532986690383b18389c8c6932f754a002ad90ce58aa9c58231c065',
       i686: '046c2d8c3ffdae2a222630661c4f05eb7973b33ecffcdc990b24d4be573943c5',
     x86_64: 'c9c98c8676017c9d141aec4c1ce97cfa83704f6f68bfdcf964d599daa1210825'
  })

  depends_on 'py3_zipp'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
