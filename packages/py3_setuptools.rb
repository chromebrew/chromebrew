require 'buildsystems/pip'
require 'ptools'

class Py3_setuptools < Pip
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  version "80.10.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  # source_url 'https://github.com/pypa/setuptools.git'
  # git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b1c11ffa86e401e83f12b643cd72b2459f0a6df8abc7d93ac50e4991ee85a264',
     armv7l: 'b1c11ffa86e401e83f12b643cd72b2459f0a6df8abc7d93ac50e4991ee85a264',
       i686: 'f25c11433f37a76f8ff40155f87aeaa0ca5d7f49c478ffe72bbd5329bba2dae5',
     x86_64: '50b01fbd2ff178c2e10849ebae62b50d4616d949cf49f387e7fef63b5b542ff1'
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
