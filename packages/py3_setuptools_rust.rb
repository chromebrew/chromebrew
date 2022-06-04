require 'package'

class Py3_setuptools_rust < Package
  description 'Setuptools-rust provides rust support for setuptools.'
  homepage 'https://github.com/PyO3/setuptools-rust/'
  @_ver = '1.3.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/setuptools-rust.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_rust/1.3.0_armv7l/py3_setuptools_rust-1.3.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_rust/1.3.0_armv7l/py3_setuptools_rust-1.3.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_rust/1.3.0_i686/py3_setuptools_rust-1.3.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_rust/1.3.0_x86_64/py3_setuptools_rust-1.3.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c725d06dbdedac04f9bb7d25643fda3dd24b9ba1a0ac0b1079d6b716f4c716e2',
     armv7l: 'c725d06dbdedac04f9bb7d25643fda3dd24b9ba1a0ac0b1079d6b716f4c716e2',
       i686: '6497b39eddb9e1bda26824354fc5b4cf120ad48d15e8575ce2b4c7697a375745',
     x86_64: '8dea8ecbc82ae2cc55da4a3a0250f433bfbbb19391c69b870a3189fda10dbdf5'
  })

  depends_on 'rust'
  depends_on 'py3_semantic_version'
  depends_on 'py3_setuptools'
  depends_on 'py3_setuptools_scm' => :build

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
