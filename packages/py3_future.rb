require 'package'

class Py3_future < Package
  description 'Future provides clean single-source support for Python 3 and 2.'
  homepage 'https://python-future.org/'
  @_ver = '0.18.2'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/PythonCharmers/python-future.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_future/0.18.2_armv7l/py3_future-0.18.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_future/0.18.2_armv7l/py3_future-0.18.2-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_future/0.18.2_x86_64/py3_future-0.18.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '2f45cc2a262e3ee766966df030ef2abd7fa35088a175051a0d58c579b131dfcc',
     armv7l: '2f45cc2a262e3ee766966df030ef2abd7fa35088a175051a0d58c579b131dfcc',
     x86_64: 'd3de1fd3a86c74ce4ed4d34e90d034b2de0cb8717e79c6398b022c7592159294'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
