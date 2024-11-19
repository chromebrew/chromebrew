require 'buildsystems/python'
require 'ptools'

class Py3_setuptools < Python
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  version "75.5.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/setuptools.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e7f186aab1a96f7ecd74ecca5f9030c2aa63d0b06a434ef7ba3d04ce34942de3',
     armv7l: 'e7f186aab1a96f7ecd74ecca5f9030c2aa63d0b06a434ef7ba3d04ce34942de3',
       i686: '0f54f158046bcae6b12917676b7df9ff707d9b61c8e738ee8dbd6c6bc25d31c5',
     x86_64: '3610ee814e370348c95d5b4450532b93120f15bdef38c4c6e7fc0d741d57b8b3'
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
