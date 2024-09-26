require 'buildsystems/python'

class Py3_pip < Python
  description 'Pip is the python package manager from the Python Packaging Authority.'
  homepage 'https://pip.pypa.io/'
  version "24.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pip.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2e7168e1d1ccdcfd42b5a9181b0683c061cf575bc094db0b47aefe7f7aad4485',
     armv7l: '2e7168e1d1ccdcfd42b5a9181b0683c061cf575bc094db0b47aefe7f7aad4485',
       i686: 'adce1acb063b981c89968c8f0a7a65e3d6d523da8ed539fe238db2257d009fda',
     x86_64: 'ee96eb9281818bccef5dcd913479e5d5694038188ea94ffc5cb467261073017d'
  })

  depends_on 'python3', '< 3.13.0'
  conflicts_ok

  def self.postinstall
    puts 'Updating pip package...'.lightblue
    system 'PIP_DISABLE_PIP_VERSION_CHECK=1 python -m pip install --upgrade --force-reinstall pip', exception: false
  end
end
