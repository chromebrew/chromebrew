require 'package'
require_relative 'libxml2'

class Py3_libxml2 < Package
  description 'Libxml2-python provides access to libxml2 and libxslt in Python.'
  homepage 'https://gitlab.gnome.org/GNOME/libxml2/'
  @_ver = '2.11.4'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2/-/archive/v2.11.4/libxml2-v2.11.4.tar.bz2'
  source_sha256 'a9493ae091f58037dd5e73fc6035a4907eae58e2cc4756abc4e6253ee6036166'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libxml2/2.11.4-py3.11_armv7l/py3_libxml2-2.11.4-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libxml2/2.11.4-py3.11_armv7l/py3_libxml2-2.11.4-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libxml2/2.11.4-py3.11_i686/py3_libxml2-2.11.4-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libxml2/2.11.4-py3.11_x86_64/py3_libxml2-2.11.4-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9f6edbeffcd732e665818153aa2f8fa3ba3c0131148dda8cc64c4f8a3d70436f',
     armv7l: '9f6edbeffcd732e665818153aa2f8fa3ba3c0131148dda8cc64c4f8a3d70436f',
       i686: 'a9d44105c23ef0753af769eb45581fbb533115b76711f89e871167101fe776a9',
     x86_64: 'c9a551869aa999fe33f4c8f8916e127734f84b77677c83cd4f22bdc9cb2a3f74'
  })

  depends_on 'glibc' # R
  depends_on 'libxml2' # R
  depends_on 'libxslt' => :build
  depends_on 'python3' => :build
  depends_on 'zlibpkg' # R

  def self.build
    system 'autoreconf -fiv'
    system "./configure #{CREW_OPTIONS}"
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
