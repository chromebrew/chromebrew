require 'buildsystems/python'
require 'ptools'

class Py3_setuptools < Python
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  version "80.7.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/setuptools.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e05de7d0040c98f24a71a3d4df79aa7561bff5a033d9d770f082772d5a45bef5',
     armv7l: 'e05de7d0040c98f24a71a3d4df79aa7561bff5a033d9d770f082772d5a45bef5',
       i686: 'f1b68a0b9945059b4d10aa7a8def0aa3510b1415ae031cdd92438df3bf6f1b8a',
     x86_64: '99727dedb0031111f55835c7955206f15eeb23105782d2f641a6755df40f5295'
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
