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
    aarch64: '4a1bf5f6b0bf5e4d7370cf0df0c8c9dd49e960c3f04d0c242d3b375239de012b',
     armv7l: '4a1bf5f6b0bf5e4d7370cf0df0c8c9dd49e960c3f04d0c242d3b375239de012b',
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
