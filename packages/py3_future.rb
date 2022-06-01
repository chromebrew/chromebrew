require 'package'

class Py3_future < Package
  description 'Future provides clean single-source support for Python 3 and 2.'
  homepage 'https://python-future.org/'
  @_ver = '0.18.2'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/PythonCharmers/python-future.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_future/0.18.2-1_armv7l/py3_future-0.18.2-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_future/0.18.2-1_armv7l/py3_future-0.18.2-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_future/0.18.2-1_i686/py3_future-0.18.2-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_future/0.18.2-1_x86_64/py3_future-0.18.2-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '5c696cdddcbf64c1a5b8c08899e214e3f19eed0c1b1896b458fac11fc1ae2070',
     armv7l: '5c696cdddcbf64c1a5b8c08899e214e3f19eed0c1b1896b458fac11fc1ae2070',
       i686: 'b1ac5ac4f611459c88850f81d697037474b432d3a9e7b23ae1d9849ac31179c6',
     x86_64: 'cf951bf6550bf5c0adc0bfd048704b55362d1ac0441c967a81cf23372fde921c'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
