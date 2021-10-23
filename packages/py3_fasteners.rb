require 'package'

class Py3_fasteners < Package
  description 'Fasteners provides useful locks for python programs.'
  homepage 'https://github.com/harlowja/fasteners/'
  @_ver = '0.16.3'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/harlowja/fasteners.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_fasteners/0.16.3_armv7l/py3_fasteners-0.16.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_fasteners/0.16.3_armv7l/py3_fasteners-0.16.3-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_fasteners/0.16.3_i686/py3_fasteners-0.16.3-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_fasteners/0.16.3_x86_64/py3_fasteners-0.16.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '8c9d54e24d283fda7b1c3196388dee64f2596ef3bff433e6ec0fa0414aff1853',
     armv7l: '8c9d54e24d283fda7b1c3196388dee64f2596ef3bff433e6ec0fa0414aff1853',
       i686: '3cb36503d069a04220961a9423a27099c0477b91a6c24805c70d6dc5056a48c2',
     x86_64: '88c043f57cb6dc44a4a1c0333a28b2b6aaecf063f3fa094389ce222520f774b6'
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
