require 'package'

class Py3_markdown < Package
  description 'Markdown is a Python implementation of Markdown.'
  homepage 'https://python-markdown.github.io/'
  @_ver = '3.3.4'
  version "#{@_ver}-1"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/Python-Markdown/markdown.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_markdown/3.3.4-1_armv7l/py3_markdown-3.3.4-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_markdown/3.3.4-1_armv7l/py3_markdown-3.3.4-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_markdown/3.3.4-1_i686/py3_markdown-3.3.4-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_markdown/3.3.4-1_x86_64/py3_markdown-3.3.4-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '3572804087c4ad60bc3b67e96eb812f6c24685c01aea3f9aa43dbec688a1d38d',
     armv7l: '3572804087c4ad60bc3b67e96eb812f6c24685c01aea3f9aa43dbec688a1d38d',
       i686: 'caa494c8241be6ba00f814432af5cbe0466ec8f921677fe9695c78133912a1a3',
     x86_64: '1ce0ddb7399b90079d6a5fc24cf9273542ccf3f1b61f1fc7390bb3dd14acd90d'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
