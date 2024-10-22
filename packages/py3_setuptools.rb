require 'buildsystems/python'
require 'ptools'

class Py3_setuptools < Python
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  version "75.2.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/setuptools.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '561ab0bc8baab39a873c0fc8b8157541dd4cf5d9d15a1454a8acb9d3fa01dc29',
     armv7l: '561ab0bc8baab39a873c0fc8b8157541dd4cf5d9d15a1454a8acb9d3fa01dc29',
       i686: '5eabf8b8f9c6593bc825aa7e64ac436c41eaa4277bfce147250873b246441d87',
     x86_64: 'aca8532e2bb9c4858cf40894101c58fbd05f2463d472fe62d7b79668648fafcd'
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
