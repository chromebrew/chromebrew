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

  depends_on 'python3'
  depends_on 'py3_packaging'

  conflicts_ok

  def self.prebuild
    system 'python3 -m pip uninstall setuptools -y', exception: false
    system 'python3 -m pip install setuptools', exception: false
  end

  def self.postremove
    system 'python3 -m pip uninstall setuptools -y', exception: false
  end
end
