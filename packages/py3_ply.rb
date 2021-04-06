require 'package'

class Py3_ply < Package
  description 'Python Lex/Yacc is another implementation of lex and yacc for python.'
  homepage 'https://www.dabeaz.com/ply/'
  version '3.11'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/dabeaz/ply/archive/3.11.tar.gz'
  source_sha256 '928c5642612f4710b168d3c49c25f6ece2913a5e8d1c5e37fde5d6162fec3fd2'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
