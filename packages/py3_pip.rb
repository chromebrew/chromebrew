require 'buildsystems/python'

class Py3_pip < Python
  description 'Pip is the python package manager from the Python Packaging Authority.'
  homepage 'https://pip.pypa.io/'
  version "26.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pip.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e8f2f72e098fb61d96f91580efad739693036f9b16bf299fd1c0c69d65ad6eb2',
     armv7l: 'e8f2f72e098fb61d96f91580efad739693036f9b16bf299fd1c0c69d65ad6eb2',
       i686: 'c97bf0a90ade12457a99a4ff5cdae6e8a709c55d821b19999f1be665a6723a72',
     x86_64: 'afe70bd3d60053df44e8b0bf5ef7183f1e2b8a529e51774905bfa7cd0999e96b'
  })

  depends_on 'python3' => :logical
  conflicts_ok

  def self.postinstall
    puts 'Updating pip package...'.lightblue
    system 'PIP_DISABLE_PIP_VERSION_CHECK=1 python3 -m pip install --upgrade --force-reinstall pip', exception: false
  end
end
