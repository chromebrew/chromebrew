require 'package'

class Py3_magic < Package
  description 'Magic is a python wrapper for libmagic.'
  homepage 'https://github.com/ahupp/python-magic/'
  @_ver = '0.4.24'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ahupp/python-magic.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_magic/0.4.24_armv7l/py3_magic-0.4.24-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_magic/0.4.24_armv7l/py3_magic-0.4.24-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_magic/0.4.24_i686/py3_magic-0.4.24-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_magic/0.4.24_x86_64/py3_magic-0.4.24-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '602181d8e9bbf6e9ae21cbd224b10b7ee3d71910afcca70b591f17f71c5fa4cd',
     armv7l: '602181d8e9bbf6e9ae21cbd224b10b7ee3d71910afcca70b591f17f71c5fa4cd',
       i686: '512ebd44d8b0e9f9ddcbf2efd2b20949ee26240421b2e063d0a7580ae9682745',
     x86_64: '55237096dfb1e26cdad4b8dd1b2122e2d91362653c0ddb89becc792baa295307'
  })

  depends_on 'filecmd'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
