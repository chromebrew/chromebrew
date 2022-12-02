require 'package'

class Py3_setuptools_rust < Package
  description 'Setuptools-rust provides rust support for setuptools.'
  homepage 'https://github.com/PyO3/setuptools-rust/'
  @_ver = '1.3.0'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/setuptools-rust.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_rust/1.3.0-py3.11_armv7l/py3_setuptools_rust-1.3.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_rust/1.3.0-py3.11_armv7l/py3_setuptools_rust-1.3.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_rust/1.3.0-py3.11_i686/py3_setuptools_rust-1.3.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools_rust/1.3.0-py3.11_x86_64/py3_setuptools_rust-1.3.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '27af4b7988fc9a44f302db7df8bf95adb1a5a536310fe84f8e1bf3b757357874',
     armv7l: '27af4b7988fc9a44f302db7df8bf95adb1a5a536310fe84f8e1bf3b757357874',
       i686: '2cafd15dc1ddc325a162257dcb4522acd26c39f1da1cf8150dc0b46ac9ab46c3',
     x86_64: '9b8c843c21d0e190aa92c60232fb982c5edb1d170d2323348aebc1ac6d591a26'
  })

  depends_on 'rust'
  depends_on 'py3_semantic_version'
  depends_on 'python3'
  depends_on 'python3_scm' => :build

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
