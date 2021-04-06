require 'package'

class Scons < Package
  description 'SCons is an Open Source software construction tool that is, a next-generation build tool.'
  homepage 'https://scons.org/'
  license 'MIT'
  version '4.1.0'
  compatibility 'all'
  source_url 'http://prdownloads.sourceforge.net/scons/scons-4.1.0.tar.gz'
  source_sha256 '72d28d762e2126787f173e3d59e089239f8b2f4e9ef3114d57f10b1206985d85'

  depends_on 'python3'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
