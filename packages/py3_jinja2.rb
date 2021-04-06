require 'package'

class Py3_jinja2 < Package
  description 'Jinja2 is a modern and designer-friendly templating language for Python.'
  homepage 'https://jinja2docs.readthedocs.io/'
  version '2.11.3'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/pallets/jinja/archive/2.11.3.tar.gz'
  source_sha256 '4be44a9e55fb069347b217d2d66d51d8b0a97f2f76985b90630bb4f317eb042a'

  depends_on 'py3_markupsafe'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
