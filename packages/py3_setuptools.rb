require 'buildsystems/python'

class Py3_setuptools < Python
  description 'Setuptools is the python build system from the Python Packaging Authority.'
  homepage 'https://setuptools.readthedocs.io/'
  version '74.1.2-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/setuptools.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3621d63b8a622c3c6a9a19ec43193652bc0ff966500a558587db2571a11f4e45',
     armv7l: '3621d63b8a622c3c6a9a19ec43193652bc0ff966500a558587db2571a11f4e45',
       i686: '1535313daecfa1ddbb92780efa88ecfd5c59f8078372eeab7ca0215a2f876921',
     x86_64: 'f682404e6c62d422144c370bb33178117bda25859c166446270f33d8b42c717f'
  })

  depends_on 'python3'
  depends_on 'py3_packaging'

  conflicts_ok

  def self.prebuild
    system 'python3 -m pip uninstall setuptools -y', exception: false
    system 'python3 -m pip install setuptools', exception: false
  end

  def self.postremove
    system 'python3 -m pip uninstall setuptools -y', exception: false
  end
end
