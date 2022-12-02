require 'package'

class Py3_setuptools < Package
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  @_ver = '65.6.3'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/setuptools.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools/65.6.3-py3.11_armv7l/py3_setuptools-65.6.3-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools/65.6.3-py3.11_armv7l/py3_setuptools-65.6.3-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools/65.6.3-py3.11_i686/py3_setuptools-65.6.3-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools/65.6.3-py3.11_x86_64/py3_setuptools-65.6.3-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2bd36f8e08cc0fe3dfcb58b9cf4bdaf813fe335e29573e8ed9c123f80e61396e',
     armv7l: '2bd36f8e08cc0fe3dfcb58b9cf4bdaf813fe335e29573e8ed9c123f80e61396e',
       i686: '93b437571e80d739fb123862ff4296069a8fc460025d5a51309935c303be69d4',
     x86_64: 'dde1cabacc460a83dcf97da29314a969cd0a79b4ff6c911bd4cb1a4ac4640de7'
  })

  depends_on 'python3'
  depends_on 'py3_packaging'

  conflicts_ok

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
