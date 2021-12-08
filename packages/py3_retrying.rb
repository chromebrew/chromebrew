require 'package'

class Py3_retrying < Package
  description 'Retrying simplifies the task of adding retry behavior to just about anything.'
  homepage 'https://github.com/rholder/retrying/'
  @_ver = '1.3.3'
  version "#{@_ver}-1"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/rholder/retrying.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_retrying/1.3.3-1_armv7l/py3_retrying-1.3.3-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_retrying/1.3.3-1_armv7l/py3_retrying-1.3.3-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_retrying/1.3.3-1_i686/py3_retrying-1.3.3-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_retrying/1.3.3-1_x86_64/py3_retrying-1.3.3-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'c45e03cbf4d05c54a9461cee9da94b6529e3c0afcab28cd460a37783f3048441',
     armv7l: 'c45e03cbf4d05c54a9461cee9da94b6529e3c0afcab28cd460a37783f3048441',
       i686: 'ae1001d2b929b556f65802c12acc0be57cfae7d21f223232f4d1b252e3cf5bd5',
     x86_64: 'e2959eed9284e9e306e1168b47bf81c242041359ca33311fc1c30c34b4a94b3b'
  })

  depends_on 'py3_six'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
