require 'package'

class Py3_markdown < Package
  description 'Markdown is a Python implementation of Markdown.'
  homepage 'https://python-markdown.github.io/'
  @_ver = '3.3.4'
  version "#{@_ver}-py3.11"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/Python-Markdown/markdown.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_markdown/3.3.4-py3.11_armv7l/py3_markdown-3.3.4-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_markdown/3.3.4-py3.11_armv7l/py3_markdown-3.3.4-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_markdown/3.3.4-py3.11_i686/py3_markdown-3.3.4-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_markdown/3.3.4-py3.11_x86_64/py3_markdown-3.3.4-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'fd0144108aacb012f2fcc47f7ccd1631c4538036ba82389491e2ccdc69d696f7',
     armv7l: 'fd0144108aacb012f2fcc47f7ccd1631c4538036ba82389491e2ccdc69d696f7',
       i686: '01fdaaf3a08c979fa8da30f8249cb3a3f42e5925bc33098d08fccbd7b347493f',
     x86_64: '0ec6f065d1d90b919a0437e9f9baff3b0ca088fa2c93eaec002bcff9bcb5e5a0'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
