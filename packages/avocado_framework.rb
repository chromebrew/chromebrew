require 'package'

class Avocado_framework < Package
  description 'Avocado is a next generation testing framework inspired by Autotest and modern development tools such as git.'
  homepage 'https://avocado-framework.github.io/'
  @_ver = '87.0'
  version @_ver
  license 'GPL-2 and GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/avocado-framework/avocado.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/avocado_framework/87.0_armv7l/avocado_framework-87.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/avocado_framework/87.0_armv7l/avocado_framework-87.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/avocado_framework/87.0_i686/avocado_framework-87.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/avocado_framework/87.0_x86_64/avocado_framework-87.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'fa01356025b6bcafda45fbbf468d0f3c29b5d4c499f8c9c0e089d1774de71c03',
     armv7l: 'fa01356025b6bcafda45fbbf468d0f3c29b5d4c499f8c9c0e089d1774de71c03',
       i686: '4734735ddbf692677d2c92d960c94ce09901c9b7c5c1cc402910bd88b71bfd54',
     x86_64: 'e51b95bf30fc88981f33b015d77150fefc4e1a77fe801691a19c86ef475ee6d8'
  })

  depends_on 'xdg_base'
  depends_on 'xzutils'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
