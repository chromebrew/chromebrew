require 'buildsystems/python'

class Py3_pip < Python
  description 'Pip is the python package manager from the Python Packaging Authority.'
  homepage 'https://pip.pypa.io/'
  version "26.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pip.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6533e46e992401cfff3c992344a0c526064c114991d07d65500bef443de4b7de',
     armv7l: '6533e46e992401cfff3c992344a0c526064c114991d07d65500bef443de4b7de',
       i686: '88f2d5728fe02e2458ab5bb58a5dd9dd83687f6aa49d6c01e2b6fe7d2546ba9d',
     x86_64: '25594d052f509bd49a27032e53ba01af41d6f8c9b7b6b97a29416865a5930dff'
  })

  depends_on 'python3' => :logical
  conflicts_ok

  def self.patch
    patches = [
      # Fix flit 4 incompatibility.
      ['https://github.com/pypa/pip/pull/14254.patch', '16e9179bff87a1cbefcb5f8e95a6a809327c2ac4af749f8caab367b5e8203e2f']
    ]
    ConvenienceFunctions.patch(patches) if version == "26.2.2-#{CREW_PY_VER}"
  end

  def self.postinstall
    puts 'Updating pip package...'.lightblue
    system 'PIP_DISABLE_PIP_VERSION_CHECK=1 python3 -m pip install --upgrade --force-reinstall pip', exception: false
  end
end
