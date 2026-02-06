require 'buildsystems/python'

class Py3_pip < Python
  description 'Pip is the python package manager from the Python Packaging Authority.'
  homepage 'https://pip.pypa.io/'
  version "26.0.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pip.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5c4bac807286b525af1ddcfc555261668ee76b0f510d02375d389037cf3c9d34',
     armv7l: '5c4bac807286b525af1ddcfc555261668ee76b0f510d02375d389037cf3c9d34',
       i686: '2d9b86688c46221cb745b9125174f500219f527177b37e0deac43ad6781ec2eb',
     x86_64: '1ec865cb00ebdc41263d2d86586a0f9e1fe824359d48de6507dd2d73661b1e27'
  })

  depends_on 'python3'
  conflicts_ok

  def self.postinstall
    puts 'Updating pip package...'.lightblue
    system 'PIP_DISABLE_PIP_VERSION_CHECK=1 python3 -m pip install --upgrade --force-reinstall pip', exception: false
  end
end
