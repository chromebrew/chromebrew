require 'buildsystems/python'
require 'ptools'

class Py3_setuptools < Python
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  version "75.8.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/setuptools.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '292319703d45dd49860df35291a78451b80d515cb387fc0fb14ad8d9a2bb930d',
     armv7l: '292319703d45dd49860df35291a78451b80d515cb387fc0fb14ad8d9a2bb930d',
       i686: 'f45815ec4fc6a29f678c76bfa90d79612058757cff3ea9ad5ce63d7fc78f0cca',
     x86_64: '69e2e76b99c37e1e61911f0c850ad067666d2700fc803d9b819ef923300f0253'
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
