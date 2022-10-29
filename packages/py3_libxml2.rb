require 'package'

class Py3_libxml2 < Package
  description 'Libxml2-python provides access to libxml2 and libxslt in Python.'
  homepage 'https://gitlab.gnome.org/GNOME/libxml2/'
  @_ver = '2.10.2'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2/-/archive/v2.10.2/libxml2-v2.10.2.tar.bz2'
  source_sha256 'd50e8a55b2797501929d3411b81d5d37ec44e9a4aa58eae9052572977c632d7a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libxml2/2.10.2_armv7l/py3_libxml2-2.10.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libxml2/2.10.2_armv7l/py3_libxml2-2.10.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libxml2/2.10.2_i686/py3_libxml2-2.10.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libxml2/2.10.2_x86_64/py3_libxml2-2.10.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '198aec6c86c106f45a2d945032ec232a5650a7a5f2630da11ad9d11eb40a7592',
     armv7l: '198aec6c86c106f45a2d945032ec232a5650a7a5f2630da11ad9d11eb40a7592',
       i686: '16f08ba727a13268c8a0a4516a9c81f1bcc9291a81d8a4c1e5cdeb2aa6473a98',
     x86_64: 'd5578c3e0aac30896b6f198e9b93988e055b5deca57dbaed7c9fda12b60aaa80'
  })

  depends_on 'libxml2'
  depends_on 'libxslt'
  depends_on 'py3_setuptools' => :build

  def self.build
    system 'autoreconf -fiv'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    Dir.chdir('python') do
      system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
    end
  end

  def self.install
    Dir.chdir('python') do
      system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS_NO_SVEM}"
    end
  end
end
