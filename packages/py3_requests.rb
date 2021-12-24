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
    aarch64: '39c5da849cab8b0764fd796ba3f2d6eccffa9ccd757c066505e34f01ded6df35',
     armv7l: '39c5da849cab8b0764fd796ba3f2d6eccffa9ccd757c066505e34f01ded6df35',
       i686: '7803bc03e7ebe20dad05d2f49d2153ac747993a3ee1289be9b24cbfd54c7e557',
     x86_64: 'cc6dfc0618a1a64a3c3f77d5f62a5de12729944960be0be572ff37648fd8f4b8'
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
