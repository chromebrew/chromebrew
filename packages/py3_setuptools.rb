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
    aarch64: 'e595efaa230884e91d50e10d01ad001939a3c16936a18f39d92d643ff3b3496d',
     armv7l: 'e595efaa230884e91d50e10d01ad001939a3c16936a18f39d92d643ff3b3496d',
       i686: '19213a9931a821f1cc9126101ee7425699aa16a92933064564e00bda7cbc98ad',
     x86_64: '4ef2ee9ab192b4ef56ee0dec0833ed99e8bee1f96d0bb04137b772fbf52057f0'
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
