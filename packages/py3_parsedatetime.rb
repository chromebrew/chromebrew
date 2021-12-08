require 'package'

class Py3_parsedatetime < Package
  description 'Parse human-readable date/time strings'
  homepage 'https://github.com/bear/parsedatetime/'
  @_ver = '2.6'
  version "#{@_ver}-1"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/bear/parsedatetime.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_parsedatetime/2.6-1_armv7l/py3_parsedatetime-2.6-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_parsedatetime/2.6-1_armv7l/py3_parsedatetime-2.6-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_parsedatetime/2.6-1_i686/py3_parsedatetime-2.6-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_parsedatetime/2.6-1_x86_64/py3_parsedatetime-2.6-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '6c7b3b8c49a27c1c611b7c6fb37d70563d048704b1a6c8ce8cf8250367b4e892',
     armv7l: '6c7b3b8c49a27c1c611b7c6fb37d70563d048704b1a6c8ce8cf8250367b4e892',
       i686: '48447988dff8b0ae37a7cd2994a1b91e1fd6c3adef4c079d5ebd79361299e56d',
     x86_64: '3662d9592e9b8d73dd3f48476ef600beac90f3296afe948506676db009142598'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
