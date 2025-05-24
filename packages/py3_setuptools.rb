require 'buildsystems/pip'
require 'ptools'

class Py3_setuptools < Pip
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  version "80.8.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/setuptools.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4a1bf5f6b0bf5e4d7370cf0df0c8c9dd49e960c3f04d0c242d3b375239de012b',
     armv7l: '4a1bf5f6b0bf5e4d7370cf0df0c8c9dd49e960c3f04d0c242d3b375239de012b',
       i686: '433c3df6c9f591e144e01360a0adf87602649cd3751c084d82fd4ad6b3e91aed',
     x86_64: '5f4e0e1e6487719823c65a1dc3324b93ec189fb63297d5481cad5b618e829e4f'
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
