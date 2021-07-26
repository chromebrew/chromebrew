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

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pathspec/0.8.1_armv7l/py3_pathspec-0.8.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pathspec/0.8.1_armv7l/py3_pathspec-0.8.1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pathspec/0.8.1_x86_64/py3_pathspec-0.8.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '481821346709685a9267ac247db37279cb7511c44056edd4bbb02d4a3f4bb81a',
     armv7l: '481821346709685a9267ac247db37279cb7511c44056edd4bbb02d4a3f4bb81a',
     x86_64: 'b3f22a0db1f837e25e673b9723d9e4adb9eac2ce5f559fe74f271317b6c5fab6'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
