require 'buildsystems/python'
require 'ptools'

class Py3_setuptools < Python
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  version "75.8.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/setuptools.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '986e49837fb84e8751a673207e564c148929139a48e04d4b7079de4bd69edb26',
     armv7l: '986e49837fb84e8751a673207e564c148929139a48e04d4b7079de4bd69edb26',
       i686: 'fc3c921a2faeda4e660c4c5f12cdd7c32532d1ebbca5804b7ba9fc0b59f288ec',
     x86_64: 'fe144a503f0122c60148d5298c90b9d781c94addc34d2be27f4b7da226de024d'
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
