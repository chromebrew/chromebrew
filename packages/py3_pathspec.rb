require 'package'

class Py3_pathspec < Package
  description 'Path specification is a utility library for gitignore style pattern matching of file paths.'
  homepage 'https://github.com/cpburnz/python-path-specification/'
  @_ver = '0.8.1'
  version @_ver
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/cpburnz/python-path-specification.git'
  git_hashtag '7b125acf41702cb82679dcf56aaf6a14d34bd785'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
