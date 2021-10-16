require 'package'

class Py3_markupsafe < Package
  description 'Markupsafe allows the safe addition of untrusted strings to HTML/XML markup.'
  homepage 'https://markupsafe.palletsprojects.com/'
  @_ver = '2.0.1'
  version @_ver
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/pallets/markupsafe.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_markupsafe/2.0.1_armv7l/py3_markupsafe-2.0.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_markupsafe/2.0.1_armv7l/py3_markupsafe-2.0.1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_markupsafe/2.0.1_x86_64/py3_markupsafe-2.0.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '1c08b4851ed757bd1fed94706ee9ac956b9d4b05f136075b5706faf81266ed1a',
     armv7l: '1c08b4851ed757bd1fed94706ee9ac956b9d4b05f136075b5706faf81266ed1a',
     x86_64: '554f29131f2f8a4314a0e5e9f5927d5972509ff526283c166c557d085d7fcbd4'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
