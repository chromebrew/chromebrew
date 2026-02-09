require 'buildsystems/pip'
require 'ptools'

class Py3_setuptools < Pip
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  version "82.0.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  # source_url 'https://github.com/pypa/setuptools.git'
  # git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7eeeb6276e29f9e81c8be2681af94c8411ccc1973df902d387f96da367f55fa3',
     armv7l: '7eeeb6276e29f9e81c8be2681af94c8411ccc1973df902d387f96da367f55fa3',
       i686: 'ff2029f05267d3b70867490255a0f7791efc2eb012e7bc2b787c12337d2dafcd',
     x86_64: 'b11d7fb57e8f5bf8ea6295308869c7c665fbec7d3cf5d7aeaecece8622ca363d'
  })

  depends_on 'python3'
  depends_on 'py3_packaging'

  conflicts_ok
  no_source_build

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
