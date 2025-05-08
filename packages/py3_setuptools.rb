require 'buildsystems/python'
require 'ptools'

class Py3_setuptools < Python
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  version "80.3.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/setuptools.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '198d6409856428ac2ffd654377808c4997200987b1b95277077f5edb7820ca8e',
     armv7l: '198d6409856428ac2ffd654377808c4997200987b1b95277077f5edb7820ca8e',
       i686: '2452220fc8c14fc5b03d55e81e54a4c0fe739f198e1189a1b254a41408736114',
     x86_64: '2680e6ffd5539b56dd879f923f58e48c911aea608649564bc1e6f2e62813c8d8'
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
