require 'package'

class Py3_libxml2 < Package
  description 'Python bindings for libxml2.'
  homepage 'https://gitlab.gnome.org/GNOME/libxml2'
  version '2.13.2-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxml2.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6248e0710ebec3690a92a5a762776e8aaf31d4f4266d6298c565532d6fb92678',
     armv7l: '6248e0710ebec3690a92a5a762776e8aaf31d4f4266d6298c565532d6fb92678',
       i686: 'f8e328879434dd77a4094b64cbd95e816d0b2d4ce6b639ac51c2f531873724df',
     x86_64: '6e1e839c0118536a04baf16153d14adc8b07f09058fb6dacc21dc364215541ec'
  })

  depends_on 'glibc' # R
  depends_on 'libxml2' # R
  depends_on 'py3_setuptools' => :build
  depends_on 'python3' # R
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
