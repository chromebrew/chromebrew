require 'package'

class Py3_isodate < Package
  description 'ISOdate is an ISO 8601 date/time/duration parser and formatter.'
  homepage 'https://github.com/gweis/isodate/'
  @_ver = '0.6.0'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/gweis/isodate.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_isodate/0.6.0_armv7l/py3_isodate-0.6.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_isodate/0.6.0_armv7l/py3_isodate-0.6.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_isodate/0.6.0_i686/py3_isodate-0.6.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_isodate/0.6.0_x86_64/py3_isodate-0.6.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '57aafbcb7ced6fac9c9da17d559335af7ab58514486134c487c8fcd3a74bbd1f',
     armv7l: '57aafbcb7ced6fac9c9da17d559335af7ab58514486134c487c8fcd3a74bbd1f',
       i686: '066242b6111d41022db807181e66f7a9977c25ada212715cd904ef9bfe15f7ce',
     x86_64: '5e78bca4f6b3af312a3e9f3115ea78b374c686117b64e3ffeb090b8284ab2df3'
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
