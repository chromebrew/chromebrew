require 'buildsystems/python'
require 'ptools'

class Py3_setuptools < Python
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  version "76.0.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/setuptools.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '292319703d45dd49860df35291a78451b80d515cb387fc0fb14ad8d9a2bb930d',
     armv7l: '292319703d45dd49860df35291a78451b80d515cb387fc0fb14ad8d9a2bb930d',
       i686: 'e1447fcf18caaa72fdd2d7dbabe1e847f5b69beeb7e61f3e6d2d24673c30a3ef',
     x86_64: '7d7833a710aaf22721ca73324a2975c16f9f4ab59c5cf317fafbcef4bd173115'
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
