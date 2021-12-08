require 'package'

class Py3_greenlet < Package
  description 'Greenlet provides lightweight in-process concurrent programming.'
  homepage 'https://greenlet.readthedocs.io/'
  @_ver = '1.1.2'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/python-greenlet/greenlet.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_greenlet/1.1.2_armv7l/py3_greenlet-1.1.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_greenlet/1.1.2_armv7l/py3_greenlet-1.1.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_greenlet/1.1.2_i686/py3_greenlet-1.1.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_greenlet/1.1.2_x86_64/py3_greenlet-1.1.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'e0731ba05fff6bcc0ae7d44ccf6e01699005c6a84575db380e36c9239cab6019',
     armv7l: 'e0731ba05fff6bcc0ae7d44ccf6e01699005c6a84575db380e36c9239cab6019',
       i686: '0a3265b74ad646f7cde2befee5e83a9abc4cf74b98d37aa84adac09a988b7dd0',
     x86_64: 'eadda0040122298dc2f6a4d62702175de430367a2eb0d530a256c19961a59dfa'
  })

  depends_on 'py3_agate'
  depends_on 'py3_sqlalchemy'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
