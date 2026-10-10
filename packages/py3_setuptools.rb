require 'buildsystems/pip'
require 'ptools'

class Py3_setuptools < Pip
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  version "84.0.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  # source_url 'https://github.com/pypa/setuptools.git'
  # git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '990f9f63aa82e81a5a13609dc39f527d3e72e8df380a3c6a5da286646a80372e',
     armv7l: '990f9f63aa82e81a5a13609dc39f527d3e72e8df380a3c6a5da286646a80372e',
       i686: '0c0e69775661e9ba135f739bea0274d763b4838dca8f07b29f700476f41bb013',
     x86_64: '0769a762ec96ccbf939518d78b3919b3ba00af61c6358636aefa10e25201ac6a'
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
