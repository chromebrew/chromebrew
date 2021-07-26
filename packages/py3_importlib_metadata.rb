require 'package'

class Py3_importlib_metadata < Package
  description 'Importlib metadata reads metadata from Python packages.'
  homepage 'https://github.com/python/importlib_metadata/'
  @_ver = '4.6.1'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/python/importlib_metadata.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_importlib_metadata/4.6.1_armv7l/py3_importlib_metadata-4.6.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_importlib_metadata/4.6.1_armv7l/py3_importlib_metadata-4.6.1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_importlib_metadata/4.6.1_x86_64/py3_importlib_metadata-4.6.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '5568b64c5d7d8b967a739a3f21fb2a718daedb34a41f15290649e32ecbacbe74',
     armv7l: '5568b64c5d7d8b967a739a3f21fb2a718daedb34a41f15290649e32ecbacbe74',
     x86_64: '55de7326823289d71254bc10fb31b58578072b27c09abc203f604fb9005ac27a'
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
