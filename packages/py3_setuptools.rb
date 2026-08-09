require 'buildsystems/pip'
require 'ptools'

class Py3_setuptools < Pip
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  version "84.0.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  # source_url 'https://github.com/pypa/setuptools.git'
  # git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '80eab8b3357e604191d6209e8406653cc4183a9b644b992dff1a766e4b70afd1',
     armv7l: '80eab8b3357e604191d6209e8406653cc4183a9b644b992dff1a766e4b70afd1',
       i686: '059087aae3aa0bfc3aa1d7e2ebf9fe97e305aefebe163378d51f4aebc005e0a7',
     x86_64: '3a7d008148037b4f4c2cda56d6f211b49e65ba07ae388155106f5b0163be8fe7'
  })

  depends_on 'py3_packaging'
  depends_on 'python3' => :logical

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
