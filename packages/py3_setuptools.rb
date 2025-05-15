require 'buildsystems/python'
require 'ptools'

class Py3_setuptools < Python
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  version "80.6.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/setuptools.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f5b8dc14b756364cf5817cc0f6273a2c905d8a038866e5b2b56704ae6a789a29',
     armv7l: 'f5b8dc14b756364cf5817cc0f6273a2c905d8a038866e5b2b56704ae6a789a29',
       i686: '3796fbefbcb627f9569c1292d7c4bdcf593c87902270d3160484e0cfbf8876ae',
     x86_64: '4b876ffed5a76e194550bf22dc9f0dfe0ff34c9e1f33873c6ed691db0b3078a8'
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
