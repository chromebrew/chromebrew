require 'package'

class Py3_libxml2 < Package
  description 'Libxml2-python provides access to libxml2 and libxslt in Python.'
  homepage 'https://gitlab.gnome.org/GNOME/libxml2/'
  @_ver = '2.9.12'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libxml2/2.9.12-1_armv7l/py3_libxml2-2.9.12-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libxml2/2.9.12-1_armv7l/py3_libxml2-2.9.12-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libxml2/2.9.12-1_i686/py3_libxml2-2.9.12-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_libxml2/2.9.12-1_x86_64/py3_libxml2-2.9.12-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '294e8d2501c98250ad2117c09f866021148c956df29e5135fd7136efb35a1c25',
     armv7l: '294e8d2501c98250ad2117c09f866021148c956df29e5135fd7136efb35a1c25',
       i686: '2892ad9f92680d8874d7a84c55c22b0f87a590859b93a430ff4d04e194d749c8',
     x86_64: 'f1bbbf7ef05b9fdda461142c46e91d9d01c06b05e3bb3a470b759c55ab9b22f9'
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
