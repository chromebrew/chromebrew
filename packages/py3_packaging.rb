require 'package'

class Py3_packaging < Package
  description 'Packaging provides core utilities for Python packages'
  homepage 'https://packaging.pypa.io/'
  @_ver = '21.3'
  version @_ver
  license 'BSD-2 or Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/pypa/packaging.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/21.3_armv7l/py3_packaging-21.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/21.3_armv7l/py3_packaging-21.3-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/21.3_i686/py3_packaging-21.3-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/21.3_x86_64/py3_packaging-21.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '469e4712247c92fac3ffd8d494fc729e25d434ac9fc6a8fe36b781a4da6e5b37',
     armv7l: '469e4712247c92fac3ffd8d494fc729e25d434ac9fc6a8fe36b781a4da6e5b37',
       i686: '5c9b22be25b6e750af2e79f107243c0ce4aaa01fdeb031650602152bb920b3bf',
     x86_64: 'c18e092f10ce84cb715fa94b38ee38af4c99ddeeaeb6bfc5a5c4b5408b44135d'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
