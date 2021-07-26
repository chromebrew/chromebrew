require 'package'

class Py3_requests < Package
  description 'Requests is a simple, yet elegant, HTTP library.'
  homepage 'https://docs.python-requests.org/'
  @_ver = '2.25.1'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/psf/requests.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_requests/2.25.1_armv7l/py3_requests-2.25.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_requests/2.25.1_armv7l/py3_requests-2.25.1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_requests/2.25.1_x86_64/py3_requests-2.25.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '02ff6c040ddd7ecb5d8513e921fea179775582472352efed67edf539eefef0ba',
     armv7l: '02ff6c040ddd7ecb5d8513e921fea179775582472352efed67edf539eefef0ba',
     x86_64: '740645baf795270ca05fffd76ff190d9c31f8cd87414ee406846baae770ba1fa'
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
