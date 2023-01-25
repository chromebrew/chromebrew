require 'package'

class Py3_ply < Package
  description 'Python Lex/Yacc is an implementation of lex and yacc parsing tools for Python.'
  homepage 'https://www.dabeaz.com/ply/index.html'
  @_ver = '3.11'
  version "#{@_ver}-py3.11"
  license 'BSD'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/e5/69/882ee5c9d017149285cab114ebeab373308ef0f874fcdac9beb90e0ac4da/ply-3.11.tar.gz'
  source_sha256 '00c7c1aaa88358b9c765b6d3000c6eec0ba42abca5351b095321aef446081da3'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ply/3.11-py3.11_armv7l/py3_ply-3.11-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ply/3.11-py3.11_armv7l/py3_ply-3.11-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ply/3.11-py3.11_i686/py3_ply-3.11-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ply/3.11-py3.11_x86_64/py3_ply-3.11-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a5b12de8ea7e0d2444ef295f20df024aa3203d85bc0b8b563f02fa34267825cf',
     armv7l: 'a5b12de8ea7e0d2444ef295f20df024aa3203d85bc0b8b563f02fa34267825cf',
       i686: '66b293c5030e50f82b2e3049f1985f79dd03eb1c712453cb6844e154b281f706',
     x86_64: '750e99c7798c4106e81f97fd3e0baf7074043083ebc4fe15d0648b3ed09bfdb7'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
