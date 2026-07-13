require 'buildsystems/pip'
require 'ptools'

class Py3_setuptools < Pip
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  version "83.0.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  # source_url 'https://github.com/pypa/setuptools.git'
  # git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9335c3e6399d7d3ea73f1ffc7f373263c140e8aeb77bb0278e299eafb0d8d8d9',
     armv7l: '9335c3e6399d7d3ea73f1ffc7f373263c140e8aeb77bb0278e299eafb0d8d8d9',
       i686: '1b1495abb4927e16b460ff1333778c1543c8bd07252a17dcba270c2680ae8ec8',
     x86_64: 'ee703f703e489f76c387544fe80bcba8fc86ef0927bfc0b6416a10c7ffc124bf'
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
