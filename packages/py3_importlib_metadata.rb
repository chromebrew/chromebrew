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
    aarch64: '14ec8523f8dbad3d220e1d510d7c49b7f96321a371e51a9731156b155d53cfef',
     armv7l: '14ec8523f8dbad3d220e1d510d7c49b7f96321a371e51a9731156b155d53cfef',
       i686: '10879b8a3fda17a44e4eedbfa42cb3f1d7cb32118f0ff817bf380309947e9da3',
     x86_64: '41a7eac4c33d58b052aee44c73102cd560617d32ad325546a08ec715b4072426'
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
