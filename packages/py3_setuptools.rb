require 'buildsystems/pip'
require 'ptools'

class Py3_setuptools < Pip
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  version "80.10.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  # source_url 'https://github.com/pypa/setuptools.git'
  # git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0192d446c7b46e28f205fc18775a1bfe5f4c922845dabbc0b9b6995672552c6c',
     armv7l: '0192d446c7b46e28f205fc18775a1bfe5f4c922845dabbc0b9b6995672552c6c',
       i686: '8a091b5df65f447f903d86cfcb68c9e1bb27781d53f71182cdc8430c6da7d198',
     x86_64: '63847d1e3ab7064f80a0a86d8f2b7149b0dd4a5b7129de3e80dc3e5702d22d2c'
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
