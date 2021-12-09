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
    aarch64: '83e126ed957af789ed654ced0691b665c6b00a462dffe50e30452a5691c7c6b0',
     armv7l: '83e126ed957af789ed654ced0691b665c6b00a462dffe50e30452a5691c7c6b0',
       i686: '46309e4e84bb0e885fce67b71417a961cd0a441c3ea3933b4af7133ea6b0c49d',
     x86_64: '993a31bef230e06ff6815816740707eabf8af60dbf1bb7c9456745370034c873'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
