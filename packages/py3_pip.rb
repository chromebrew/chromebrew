require 'package'

class Py3_pip < Package
  description 'Pip is the python package manager from the Python Packaging Authority.'
  homepage 'https://pip.pypa.io/'
  @_ver = '22.3.1'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pip.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pip/22.3.1-py3.11_armv7l/py3_pip-22.3.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pip/22.3.1-py3.11_armv7l/py3_pip-22.3.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pip/22.3.1-py3.11_i686/py3_pip-22.3.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pip/22.3.1-py3.11_x86_64/py3_pip-22.3.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '023cc76bd338a1d14b6ed45d55e8fe6b05454145abe941cc0fdec3d0bbf5ffe4',
     armv7l: '023cc76bd338a1d14b6ed45d55e8fe6b05454145abe941cc0fdec3d0bbf5ffe4',
       i686: '3826d8987e023d5afa98cb322a6f920fcbbc37c83d82ec4e048b28c7fd16cdaf',
     x86_64: 'af52f8111904a49684b37251cc65c8d5dc9235238ecf49aa56a27fb95bd1c994'
  })

  depends_on 'python3', '< 3.11.0'

  conflicts_ok

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"

    # Make pip3 the default pip
    # FileUtils.ln_s "pip3", "#{CREW_DEST_PREFIX}/bin/pip" # This automatically happens
  end
end
