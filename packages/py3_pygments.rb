require 'package'

class Py3_pygments < Package
  description 'Python Syntax Highlighter'
  homepage 'https://pygments.org/'
  @_ver = '2.10.0'
  version @_ver
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/pygments/pygments.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pygments/2.10.0_armv7l/py3_pygments-2.10.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pygments/2.10.0_armv7l/py3_pygments-2.10.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pygments/2.10.0_i686/py3_pygments-2.10.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pygments/2.10.0_x86_64/py3_pygments-2.10.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '5d059307372152d1913ce16ed8c4b93ffa7c38f9a84a7f7d8b0abef418030641',
     armv7l: '5d059307372152d1913ce16ed8c4b93ffa7c38f9a84a7f7d8b0abef418030641',
       i686: '007df1e0152019b04e7b51313c4ed69a1670acc8931fa7ccd2424361f58eda7a',
     x86_64: '22d65dbc8ac96184a947a30b3a46db53b4ebb366be940e3850febc9153303511'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
