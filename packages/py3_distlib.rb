require 'package'

class Py3_distlib < Package
  description 'Distlib provides distribution utilities for Python packages.'
  homepage 'https://bitbucket.org/pypa/distlib/'
  @_ver = '0.3.2'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://bitbucket.org/pypa/distlib.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_distlib/0.3.2_armv7l/py3_distlib-0.3.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_distlib/0.3.2_armv7l/py3_distlib-0.3.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_distlib/0.3.2_i686/py3_distlib-0.3.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_distlib/0.3.2_x86_64/py3_distlib-0.3.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '18fd550533021acdb15094fe16cc5e32e2772bc261b0985ce75e85b65adb8a88',
     armv7l: '18fd550533021acdb15094fe16cc5e32e2772bc261b0985ce75e85b65adb8a88',
       i686: 'ed4d8bc782bf774a4a9108d6397bfb418529c18ee1a47bb5355a97d81f1dc3e9',
     x86_64: '82aa5ef3eafe8b9c30839368790abda19dfec294191dee3a1165f4805a163692'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS_NO_SVEM}"
  end
end
