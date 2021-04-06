require 'package'

class Py3_attrs < Package
  description 'Attrs is the python package that helps in writing classes by removing needs to implement object protocols.'
  homepage 'https://www.attrs.org/'
  version '20.3.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/python-attrs/attrs/archive/20.3.0.tar.gz'
  source_sha256 'c7d2ef493768bfea33cd5d8cbd2a6c2ddf229d5e8c3a79aefa67d1daf1e9d96d'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
