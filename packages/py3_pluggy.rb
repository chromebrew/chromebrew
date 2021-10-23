require 'package'

class Py3_pluggy < Package
  description 'Pluggy provides plugin and hook calling mechanisms for Python.'
  homepage 'https://pluggy.readthedocs.io/'
  @_ver = '1.0.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pytest-dev/pluggy.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pluggy/1.0.0_armv7l/py3_pluggy-1.0.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pluggy/1.0.0_armv7l/py3_pluggy-1.0.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pluggy/1.0.0_i686/py3_pluggy-1.0.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pluggy/1.0.0_x86_64/py3_pluggy-1.0.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '47e1a71a1f2f263e93072a420737fd795ddd64fa637aa7d0a464dcbb0ddc03bb',
     armv7l: '47e1a71a1f2f263e93072a420737fd795ddd64fa637aa7d0a464dcbb0ddc03bb',
       i686: 'c3d73f15a8aa0a0d97f7e2721289510d31855f0a9dcdfb309fcfc3cdf92514f5',
     x86_64: 'a2d8e2293eac1b7c8b8cd13054199339fd0a97c78764da30de944349b0bef34a'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
