require 'package'

class Py2_six < Package
  description 'Six is a Python 2 and 3 compatibility library.'
  homepage 'https://six.readthedocs.io/'
  version '1.15.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/benjaminp/six.git'
  git_hashtag version
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py2_six/1.15.0_armv7l/py2_six-1.15.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py2_six/1.15.0_armv7l/py2_six-1.15.0-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py2_six/1.15.0_i686/py2_six-1.15.0-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py2_six/1.15.0_x86_64/py2_six-1.15.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '7a5eb26a32d16ec92ff73cdf5fe85bc20810d0805e7280f1f2ce2a3db3becab4',
     armv7l: '7a5eb26a32d16ec92ff73cdf5fe85bc20810d0805e7280f1f2ce2a3db3becab4',
       i686: 'c147094d65bbbfccde10c89c572c69085a70dbf8b83b08d20d5eccbfa5da4db9',
     x86_64: '360cfb9534fe9c0e4efe450c2267519b60acecac2429a90b7b2fabbe7da77c24'
  })

  depends_on 'python2'
  depends_on 'py2_setuptools' => :build

  def self.build
    system "python2 setup.py build #{PY2_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python2 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
