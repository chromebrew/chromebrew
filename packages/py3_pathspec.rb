require 'package'

class Py3_pathspec < Package
  description 'Path specification is a utility library for gitignore style pattern matching of file paths.'
  homepage 'https://github.com/cpburnz/python-path-specification/'
  @_ver = '0.9.0'
  version "#{@_ver}-py3.11"
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/cpburnz/python-path-specification.git'
  git_hashtag '7b125acf41702cb82679dcf56aaf6a14d34bd785'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pathspec/0.9.0-py3.11_armv7l/py3_pathspec-0.9.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pathspec/0.9.0-py3.11_armv7l/py3_pathspec-0.9.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pathspec/0.9.0-py3.11_i686/py3_pathspec-0.9.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pathspec/0.9.0-py3.11_x86_64/py3_pathspec-0.9.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1221f9bbea4d7f1731a55a31280ef64d1d696f47fe060ca2e5081a0390ce799f',
     armv7l: '1221f9bbea4d7f1731a55a31280ef64d1d696f47fe060ca2e5081a0390ce799f',
       i686: 'fe1135b7be4c499a15e760c0d3b7f3d1477073d0df25cfe081fdcf90104fe656',
     x86_64: '30e5b78e216257ffa93c6b819375a242336f6eed428c302de97f124647242952'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
