require 'package'

class Py3_arrow < Package
  description 'Arrow is a Python library that offers a sensible and human-friendly approach to creating, manipulating, formatting and converting dates, times and timestamps.'
  homepage 'https://arrow.readthedocs.io/'
  @_ver = '1.1.1'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/arrow-py/arrow.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_arrow/1.1.1_armv7l/py3_arrow-1.1.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_arrow/1.1.1_armv7l/py3_arrow-1.1.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_arrow/1.1.1_i686/py3_arrow-1.1.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_arrow/1.1.1_x86_64/py3_arrow-1.1.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '986630aa58ab127f281a17571ec81fc3b4341c60f146338345ea0aeb8dd1fdea',
     armv7l: '986630aa58ab127f281a17571ec81fc3b4341c60f146338345ea0aeb8dd1fdea',
       i686: 'ffd0888852abff12a8ae6fe7efba70ea1c17cf7fadbf046f84af23ca98117df2',
     x86_64: '358015e54220d6c193330fc626c56593441fba71d3a7a6e05aacfac119b35dc0'
  })

  depends_on 'py3_dateutil'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
