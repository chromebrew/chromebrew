require 'package'

class Avocado_framework < Package
  description 'Avocado is a next generation testing framework inspired by Autotest and modern development tools such as git.'
  homepage 'https://avocado-framework.github.io/'
  version '94.0'
  license 'GPL-2 and GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/avocado-framework/avocado.git'
  git_hashtag version
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/avocado_framework/94.0_armv7l/avocado_framework-94.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/avocado_framework/94.0_armv7l/avocado_framework-94.0-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/avocado_framework/94.0_i686/avocado_framework-94.0-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/avocado_framework/94.0_x86_64/avocado_framework-94.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'c687be4dd45ff08f79449baa438f8ba6eb27d9ec9a78759c63a2827c325e6ae3',
     armv7l: 'c687be4dd45ff08f79449baa438f8ba6eb27d9ec9a78759c63a2827c325e6ae3',
       i686: '2751e897254e5edc450a986ff98b7e07af21dfbff7c75d7ddf5cd16a3d0b65b7',
     x86_64: '210640e2c6917979fd6b69ab54e2e786dfb5d0d26c7efba653e70253d266a571'
  })

  depends_on 'xdg_base'
  depends_on 'xzutils'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
