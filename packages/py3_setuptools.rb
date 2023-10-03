require 'package'

class Py3_setuptools < Package
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  @_ver = '68.2.2'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/setuptools.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools/68.2.2-py3.12_armv7l/py3_setuptools-68.2.2-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools/68.2.2-py3.12_armv7l/py3_setuptools-68.2.2-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools/68.2.2-py3.12_i686/py3_setuptools-68.2.2-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_setuptools/68.2.2-py3.12_x86_64/py3_setuptools-68.2.2-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8dbc12e7f86522edd17c1572564238366ca360045ce9b417347596277a4783d5',
     armv7l: '8dbc12e7f86522edd17c1572564238366ca360045ce9b417347596277a4783d5',
       i686: 'b3b4fab0b18ddeb6257b77de2609133a8446a775bd370cb3c2aae7e7df534878',
     x86_64: 'c11bc375309b042e5aa6d61caab29b843221bbe2bc470a1f269eb8e056fd180b'
  })

  depends_on 'python3', '< 3.13.0'
  depends_on 'py3_packaging'

  conflicts_ok

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
