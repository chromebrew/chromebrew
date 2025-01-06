require 'buildsystems/python'
require 'ptools'

class Py3_setuptools < Python
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  version "75.7.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/setuptools.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '986e49837fb84e8751a673207e564c148929139a48e04d4b7079de4bd69edb26',
     armv7l: '986e49837fb84e8751a673207e564c148929139a48e04d4b7079de4bd69edb26',
       i686: '19213a9931a821f1cc9126101ee7425699aa16a92933064564e00bda7cbc98ad',
     x86_64: 'a1f4e172d550557c55bc71294676a7e862c524ecdd83ac77c1952118fe2c97c7'
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
