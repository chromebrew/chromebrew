require 'package'

class Py3_markdown < Package
  description 'Markdown is a Python implementation of Markdown.'
  homepage 'https://python-markdown.github.io/'
  @_ver = '3.3.4'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/Python-Markdown/markdown.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_markdown/3.3.4_armv7l/py3_markdown-3.3.4-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_markdown/3.3.4_armv7l/py3_markdown-3.3.4-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_markdown/3.3.4_x86_64/py3_markdown-3.3.4-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '1b2adf8265bba21545e029127806cd2523d4fa43a609494ce9202eb0af7f93b3',
     armv7l: '1b2adf8265bba21545e029127806cd2523d4fa43a609494ce9202eb0af7f93b3',
     x86_64: '08d6d1d753b8bb9eb34d5269b17196e25b3d5372335b70bea1130bd87a441d8c'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
