require 'package'

class Py3_flit < Package
  description 'Flit provides simplified packaging of Python modules.'
  homepage 'https://flit.pypa.io/'
  @_ver = '3.7.1'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/flit.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flit/3.7.1-1_armv7l/py3_flit-3.7.1-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flit/3.7.1-1_armv7l/py3_flit-3.7.1-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flit/3.7.1-1_i686/py3_flit-3.7.1-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_flit/3.7.1-1_x86_64/py3_flit-3.7.1-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3455725f378233c10d8ff31cb5cb3a471546365245d07804ca663b5f4f51a844',
     armv7l: '3455725f378233c10d8ff31cb5cb3a471546365245d07804ca663b5f4f51a844',
       i686: 'a6b6a9ba748228b961f04537528a8383715de29937f25530d0066988f665caea',
     x86_64: '27bcb645fc59ae1b026d4326bc11b243fa20d5ccdad5bba23d0a1d6dd713304a'
  })

  depends_on 'py3_docutils'
  depends_on 'py3_flit_core'
  depends_on 'py3_tomli'
  depends_on 'py3_tomli_w'

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
