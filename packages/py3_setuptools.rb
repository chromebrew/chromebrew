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
    aarch64: '1e74053131192bcecea92dd5083013e3bcda9003bc10aff3556b0f8712aac296',
     armv7l: '1e74053131192bcecea92dd5083013e3bcda9003bc10aff3556b0f8712aac296',
       i686: 'bf391de4f26bf2b5d6d66e08fa71388e36e96d59042ecc53e230c0efe361fd3c',
     x86_64: 'b662422aab5e0634f1789fa8969b298408abba84f5633858fa5c47b4a43f242d'
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
