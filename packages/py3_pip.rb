require 'buildsystems/python'

class Py3_pip < Python
  description 'Pip is the python package manager from the Python Packaging Authority.'
  homepage 'https://pypi.python.org/pypi/pip'
  version "25.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pip.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fc02699919758029cb2c558da11090fed4500394b3c7e6412581e81f240852f8',
     armv7l: 'fc02699919758029cb2c558da11090fed4500394b3c7e6412581e81f240852f8',
       i686: '7387819e92510b87e4d723c9b9c354d5431c06130118f818df7df4b1e09e3e7b',
     x86_64: '503cf53a8faa38f6820dc136ebb6d001e1a92a14936299b5b8568f249b859dc2'
  })

  depends_on 'python3'
  conflicts_ok

  def self.postinstall
    puts 'Updating pip package...'.lightblue
    system 'PIP_DISABLE_PIP_VERSION_CHECK=1 python3 -m pip install --upgrade --force-reinstall pip', exception: false
  end
end
