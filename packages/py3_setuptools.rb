require 'buildsystems/pip'
require 'ptools'

class Py3_setuptools < Pip
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  version "80.9.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/setuptools.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '58844ff596a9626d85733e4e9df391e4f6ae6d83714385632eaf42a0fc9ab1c9',
     armv7l: '58844ff596a9626d85733e4e9df391e4f6ae6d83714385632eaf42a0fc9ab1c9',
       i686: 'cfb7eb84b774b46c12f42fdadd3685e756153d4d0cd9485e8b12a94a44679a87',
     x86_64: '326096c15b8e9eea9a9209f74e14df2cfa12662b3b9b190ce78bf6470b89bb9e'
  })

  depends_on 'python3'
  depends_on 'py3_packaging'

  conflicts_ok

  def self.prebuild
    if File.which('zstd')
      system 'python3 -m pip uninstall setuptools -y', exception: false
      system 'python3 -m pip install -I --force-reinstall --no-deps setuptools', exception: false
    end
  end

  def self.postremove
    system 'python3 -m pip uninstall setuptools -y', exception: false if Kernel.system('which zstd', %i[out err] => File::NULL)
  end
end
