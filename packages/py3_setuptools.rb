require 'buildsystems/pip'
require 'ptools'

class Py3_setuptools < Pip
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  version "84.2.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  # source_url 'https://github.com/pypa/setuptools.git'
  # git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '879eed4301206cee62780e9e82e2f31605ce5ceca16a52da7cdde37b569f6526',
     armv7l: '879eed4301206cee62780e9e82e2f31605ce5ceca16a52da7cdde37b569f6526',
       i686: '94a6b03e4f0fee69ecfe2c448d3e6a3af12112eda32581051b1b56e8f51f474d',
     x86_64: 'bffb1b867e588420aab04e779f55cbe059cefc4a199219d9dbbe0cb8fcfc773c'
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
