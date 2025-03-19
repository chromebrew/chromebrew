require 'buildsystems/python'
require 'ptools'

class Py3_setuptools < Python
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  version "76.1.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/setuptools.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '94bb0702d63bc168528494b7c62458cd7224d2f7ea1dcca9c73553463a2cdb75',
     armv7l: '94bb0702d63bc168528494b7c62458cd7224d2f7ea1dcca9c73553463a2cdb75',
       i686: '20d8d32f323c24bb83bc3b0639f1598b4e8687b9b1255ce8dcab2755af946646',
     x86_64: '3b2605b02b2adad225282c585ef83ef20abba2abae89d532af240963a7d0e818'
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
