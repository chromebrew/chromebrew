require 'package'

class Py3_requests < Package
  description 'Requests is a simple, yet elegant, HTTP library.'
  homepage 'https://docs.python-requests.org/'
  @_ver = '2.26.0'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/psf/requests.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_requests/2.26.0_armv7l/py3_requests-2.26.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_requests/2.26.0_armv7l/py3_requests-2.26.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_requests/2.26.0_i686/py3_requests-2.26.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_requests/2.26.0_x86_64/py3_requests-2.26.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '47b9c132b69654ac5c5d7454787e57f89575d6dc8d2f40229f2411285897d364',
     armv7l: '47b9c132b69654ac5c5d7454787e57f89575d6dc8d2f40229f2411285897d364',
       i686: '67ef07df23ff6b5e441aa847fe6f04cf9e97cdf798d4c06a0cc77d0fe6b666e2',
     x86_64: 'd4bf6914b6e293c65ed8e4e6c76e4d42f17a65976cfa7f153efd061014c317a8'
  })

  depends_on 'py3_chardet'
  depends_on 'py3_idna'
  depends_on 'py3_urllib3'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
