require 'package'

class Py3_greenlet < Package
  description 'Greenlet provides lightweight in-process concurrent programming.'
  homepage 'https://greenlet.readthedocs.io/'
  @_ver = '2.0.1'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/python-greenlet/greenlet.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_greenlet/2.0.1-py3.11_armv7l/py3_greenlet-2.0.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_greenlet/2.0.1-py3.11_armv7l/py3_greenlet-2.0.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_greenlet/2.0.1-py3.11_i686/py3_greenlet-2.0.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_greenlet/2.0.1-py3.11_x86_64/py3_greenlet-2.0.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'deddb4fa4dd1026a727e6c478979e589b7eb98af72bb5b6736f3292a593a9eaf',
     armv7l: 'deddb4fa4dd1026a727e6c478979e589b7eb98af72bb5b6736f3292a593a9eaf',
       i686: '9b5a7401ce2436a3cf4548553b51f4cbd9b11b2bc2a863a0443a1d1b575268ed',
     x86_64: '27af5719c318f6e517de6888077b271163e03df4d482a8781ea39716ccccb8b7'
  })

  depends_on 'py3_agate'
  depends_on 'py3_sqlalchemy'
  depends_on 'python3' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
