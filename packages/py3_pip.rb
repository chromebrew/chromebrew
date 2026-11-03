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
    aarch64: 'df34a97242e75e9d73887a5f996a6248cea1829526b6909af830b6baf944a2dc',
     armv7l: 'df34a97242e75e9d73887a5f996a6248cea1829526b6909af830b6baf944a2dc',
       i686: 'e0022bf9c5756b8581569ce32711d48dd9c9990fe28216b933d2450eb84ec0cb',
     x86_64: '63ad6bd66db754486f2baf4d36ff90b8217f60321baa07a902f7ccad3d671d16'
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
