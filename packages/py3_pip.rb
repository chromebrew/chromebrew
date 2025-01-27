require 'buildsystems/python'

class Py3_pip < Python
  description 'Pip is the python package manager from the Python Packaging Authority.'
  homepage 'https://pip.pypa.io/'
  version "25.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pip.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'acf7614782653ad995317616881fd285af59306e0a494880965df06631070aad',
     armv7l: 'acf7614782653ad995317616881fd285af59306e0a494880965df06631070aad',
       i686: 'af2f6126764a51ce1086c561ea9e1089a5af9e27f7e0783fd8653b1b64ab336c',
     x86_64: '6975212775b8a5444c22acd3ccb4fbdf0df1c00a89ee8b913c0076ec36c1dcaa'
  })

  depends_on 'python3'
  conflicts_ok

  def self.postinstall
    puts 'Updating pip package...'.lightblue
    system 'PIP_DISABLE_PIP_VERSION_CHECK=1 python3 -m pip install --upgrade --force-reinstall pip', exception: false
  end
end
