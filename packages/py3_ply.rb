require 'package'

class Py3_ply < Package
  description 'Python Lex/Yacc is an implementation of lex and yacc parsing tools for Python.'
  homepage 'https://www.dabeaz.com/ply/index.html'
  version '3.11'
  license 'BSD'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/e5/69/882ee5c9d017149285cab114ebeab373308ef0f874fcdac9beb90e0ac4da/ply-3.11.tar.gz'
  source_sha256 '00c7c1aaa88358b9c765b6d3000c6eec0ba42abca5351b095321aef446081da3'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ply/3.11_armv7l/py3_ply-3.11-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ply/3.11_armv7l/py3_ply-3.11-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ply/3.11_i686/py3_ply-3.11-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_ply/3.11_x86_64/py3_ply-3.11-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '01623b278862d6b2cc009b29d8d9caa58b3f8d5b191fe22ea762a1a9ee337137',
     armv7l: '01623b278862d6b2cc009b29d8d9caa58b3f8d5b191fe22ea762a1a9ee337137',
       i686: '312b4256f509aeddec27cf01fd369921ed55f41defb2dbe38ce46c1e45f0251b',
     x86_64: '85171b92200dec35d59d0ca62b7c3c1f0cf3aeb091b186e616a4c199829e8851'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
