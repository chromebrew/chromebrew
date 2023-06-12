require 'package'

class Py3_libxml2 < Package
  description 'Libxml2-python provides access to libxml2 and libxslt in Python.'
  homepage 'https://gitlab.gnome.org/GNOME/libxml2/'
  @_ver = '2.11.3'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2/-/archive/v2.11.3/libxml2-v2.11.3.tar.bz2'
  source_sha256 '44b38be302a103c62f80e792478a505365693349a76ea6b98e9c68aab8eab9e0'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libxml2/2.11.3-py3.11_armv7l/py3_libxml2-2.11.3-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libxml2/2.11.3-py3.11_armv7l/py3_libxml2-2.11.3-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libxml2/2.11.3-py3.11_i686/py3_libxml2-2.11.3-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libxml2/2.11.3-py3.11_x86_64/py3_libxml2-2.11.3-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '14368c1aca281a1cad20d438f0aa1f1691dd4f3f267d779f2ea74c0e565759f1',
     armv7l: '14368c1aca281a1cad20d438f0aa1f1691dd4f3f267d779f2ea74c0e565759f1',
       i686: '094122fe44f108ce885f5484cb28c9e36998dcd1ba1921bceeaf07d5ad1291c1',
     x86_64: 'c722b5134076c156ec0b505df8d8c0ede9d8da0b8f61d27508e3f9291423a951'
  })

  depends_on 'libxml2'
  depends_on 'libxslt'
  depends_on 'python3' => :build
  depends_on 'glibc' # R
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
