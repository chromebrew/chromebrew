require 'buildsystems/python'

class Py3_setuptools < Python
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  version '74.1.2-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/setuptools.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f3a0f31ba3c061d079764be008239b14e40ee4b8cac60e0f75d39d7f9d5e0e2f',
     armv7l: 'f3a0f31ba3c061d079764be008239b14e40ee4b8cac60e0f75d39d7f9d5e0e2f',
       i686: '49d57dcd49c10f827a328a744ad31f3573b1b015f2e763840b91ef2091b12456',
     x86_64: 'b9dc353616f26bad1143e3c57ab7470ad16cd8ae400465363ef2132aaf44eaee'
  })

  depends_on 'python3'
  depends_on 'py3_packaging'

  conflicts_ok

  def self.prebuild
    system 'python3 -m pip uninstall setuptools -y'
    system 'python3 -m pip install setuptools'
  end
end
