require 'package'

class Py3_requests < Package
  description 'Requests is a simple, yet elegant, HTTP library.'
  homepage 'https://docs.python-requests.org/'
  @_ver = '2.26.0'
  version "#{@_ver}-py3.11"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/psf/requests.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_requests/2.26.0-py3.11_armv7l/py3_requests-2.26.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_requests/2.26.0-py3.11_armv7l/py3_requests-2.26.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_requests/2.26.0-py3.11_i686/py3_requests-2.26.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_requests/2.26.0-py3.11_x86_64/py3_requests-2.26.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4299a8d051e0ed477d9771d6ed5fcbe04c49886beb1b954bb66aa3deab967def',
     armv7l: '4299a8d051e0ed477d9771d6ed5fcbe04c49886beb1b954bb66aa3deab967def',
       i686: 'd08be8781c7c0b16efe24efa1afe8a43cef67cd2b65947813fa1e80c39b48657',
     x86_64: 'bbc8d519d6d0ef5d1364968e354dc273075084b8a033ce859a33bfe315e95e9b'
  })

  depends_on 'py3_chardet'
  depends_on 'py3_idna'
  depends_on 'py3_urllib3'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
