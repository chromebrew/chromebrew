require 'package'

class Py3_libevdev < Package
  description 'Libevdev is a Python wrapper around the libevdev C library.'
  homepage 'https://python-libevdev.readthedocs.io/'
  @_ver = '0.9'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/libevdev/python-libevdev.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libevdev/0.9-py3.11_armv7l/py3_libevdev-0.9-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libevdev/0.9-py3.11_armv7l/py3_libevdev-0.9-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libevdev/0.9-py3.11_i686/py3_libevdev-0.9-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libevdev/0.9-py3.11_x86_64/py3_libevdev-0.9-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f9a21699ece28a833ff1a4ea39c438d890031b4e0973b8d4afcf6cd73da9d3b3',
     armv7l: 'f9a21699ece28a833ff1a4ea39c438d890031b4e0973b8d4afcf6cd73da9d3b3',
       i686: '366a9a1ef13818a3b7261c538a5a3f22a5e575c1cc47437ff72d67472dc1c0d8',
     x86_64: '1a1f346f5216d0ff006c2b5a1fbf9608274009a53c3386f704cfbcdf25390344'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
