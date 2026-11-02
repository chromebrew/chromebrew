require 'buildsystems/python'

class Py3_pip < Python
  description 'Pip is the python package manager from the Python Packaging Authority.'
  homepage 'https://pip.pypa.io/'
  version "26.2.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pip.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3004800128d2dfd1eb4b7b1888d1d9d7ca9e0bacc95c31b00e32f5a027e178be',
     armv7l: '3004800128d2dfd1eb4b7b1888d1d9d7ca9e0bacc95c31b00e32f5a027e178be',
       i686: '29b4a5fc9130593f693cd2421c29e555516314510a639ac0cbff2eb10ca15349',
     x86_64: '9b0ad1e923e54933bc0ce1b9935bfdd87ddf875d101566d39fc67c926756188f'
  })

  depends_on 'python3' => :logical
  conflicts_ok

  def self.patch
    patches = [
      # Fix flit 4 incompatibility.
      ['https://github.com/pypa/pip/pull/14254.patch', '16e9179bff87a1cbefcb5f8e95a6a809327c2ac4af749f8caab367b5e8203e2f']
    ]
    ConvenienceFunctions.patch(patches) if version == "26.2.1-#{CREW_PY_VER}"
  end

  def self.postinstall
    puts 'Updating pip package...'.lightblue
    system 'PIP_DISABLE_PIP_VERSION_CHECK=1 python3 -m pip install --upgrade --force-reinstall pip', exception: false
  end
end
