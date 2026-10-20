require 'buildsystems/pip'
require 'ptools'

class Py3_setuptools < Pip
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  version "84.2.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  # source_url 'https://github.com/pypa/setuptools.git'
  # git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e2e7112ecda2f0dedb57fff4256185bef23e3bb36455dce4e5727761fda394e9',
     armv7l: 'e2e7112ecda2f0dedb57fff4256185bef23e3bb36455dce4e5727761fda394e9',
       i686: '0b4226ade3acce9eb610265b39b157c8700dbe13e56d39d4ed469bf350c0de90',
     x86_64: 'ce3d85575513471e9a522795dcb4c3c0e8022fb09b2afef024887ccc12af23ba'
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
