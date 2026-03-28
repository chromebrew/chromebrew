require 'buildsystems/pip'
require 'ptools'

class Py3_setuptools < Pip
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  version "82.0.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  # source_url 'https://github.com/pypa/setuptools.git'
  # git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fcbdb8684d48ce04ebcb724e442c009a73c738d9352c4028a9fd8763859f8d82',
     armv7l: 'fcbdb8684d48ce04ebcb724e442c009a73c738d9352c4028a9fd8763859f8d82',
       i686: 'da2bda905e832e5154555b6a515e4279ef20343ccde7709149c6ac16924bae89',
     x86_64: '423f3704089c3cfe9f6970cb0001f9cc3250abfa0d678768fe7d5a81ca83f130'
  })

  depends_on 'py3_packaging'
  depends_on 'python3'
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
