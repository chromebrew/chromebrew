require 'buildsystems/pip'
require 'ptools'

class Py3_setuptools < Pip
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  version "82.0.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  # source_url 'https://github.com/pypa/setuptools.git'
  # git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '371806ee699cc1bf0e47fa7578c9b2b45c78779fe1355576eb5371ec1014eff2',
     armv7l: '371806ee699cc1bf0e47fa7578c9b2b45c78779fe1355576eb5371ec1014eff2',
       i686: '6cba48c863bbfea9368680d0becb5b6ad8395f6543d59d26d77915725a40eee6',
     x86_64: 'f401a9371440561c6f6d70c7c9c68c160d0f89e112bea946b5719696f82fb0ac'
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
