require 'package'

class Py3_ply < Package
  description 'Python Lex/Yacc is an implementation of lex and yacc parsing tools for Python.'
  homepage 'https://www.dabeaz.com/ply/index.html'
  @_ver = '3.11'
  version "#{@_ver}-1"
  license 'BSD'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/e5/69/882ee5c9d017149285cab114ebeab373308ef0f874fcdac9beb90e0ac4da/ply-3.11.tar.gz'
  source_sha256 '00c7c1aaa88358b9c765b6d3000c6eec0ba42abca5351b095321aef446081da3'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ply/3.11-1_armv7l/py3_ply-3.11-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ply/3.11-1_armv7l/py3_ply-3.11-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ply/3.11-1_i686/py3_ply-3.11-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ply/3.11-1_x86_64/py3_ply-3.11-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'd7ddab326d90bb43062ad192ba0bfb4d7f9584ae6ff6a8c3a8d6423746ffae3f',
     armv7l: 'd7ddab326d90bb43062ad192ba0bfb4d7f9584ae6ff6a8c3a8d6423746ffae3f',
       i686: '50505757cf2c2c227ee33628aac2694f4fc359583bc3b3a0342913ec896bd11e',
     x86_64: '51e31f286d29aeff002c0ebf9cb33c82b8f5a4c4aa50c11b8d6c2da4d569a66e'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
