require 'package'

class Py3_pathspec < Package
  description 'Path specification is a utility library for gitignore style pattern matching of file paths.'
  homepage 'https://github.com/cpburnz/python-path-specification/'
  @_ver = '0.9.0'
  version @_ver
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/cpburnz/python-path-specification.git'
  git_hashtag '7b125acf41702cb82679dcf56aaf6a14d34bd785'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pathspec/0.9.0_armv7l/py3_pathspec-0.9.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pathspec/0.9.0_armv7l/py3_pathspec-0.9.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pathspec/0.9.0_i686/py3_pathspec-0.9.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pathspec/0.9.0_x86_64/py3_pathspec-0.9.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'ed9377a9b09f6f07318383bbead08d8b4a467a0612f2708f1cf51513b6707766',
     armv7l: 'ed9377a9b09f6f07318383bbead08d8b4a467a0612f2708f1cf51513b6707766',
       i686: '41121164a8565a0a06aa1d59ceaa7dc4972ad1e200147dbc9ca9296cac1e47f0',
     x86_64: '985371d047aa811ed447de6c6028723aeba9f4548823a024ec80824094ccb080'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
