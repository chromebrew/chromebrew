require 'package'

class Py3_six < Package
  description 'Six is a Python 2 and 3 compatibility library.'
  homepage 'https://six.readthedocs.io/'
  @_ver = '1.16.0'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/benjaminp/six.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_six/1.16.0-py3.11_armv7l/py3_six-1.16.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_six/1.16.0-py3.11_armv7l/py3_six-1.16.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_six/1.16.0-py3.11_i686/py3_six-1.16.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_six/1.16.0-py3.11_x86_64/py3_six-1.16.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '35994cf4b811881f58ecf4d2f964a877c090c58d5d883ac922d851941d29307f',
     armv7l: '35994cf4b811881f58ecf4d2f964a877c090c58d5d883ac922d851941d29307f',
       i686: '9467d5236d5b521c99159371c417e805d68805de5d360dbfcaff55bdf970c2a5',
     x86_64: '056f49de17d05f7041a0e148f7d646cab8775e5fe6fe362b81f6f247b35e2516'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
