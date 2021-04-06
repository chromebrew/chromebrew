require 'package'

class Py3_dateutil < Package
  description 'Python dateutil provides extensions to the standard python datetime module.'
  homepage 'https://dateutil.readthedocs.io/'
  version '2.8.1'
  license 'Apache-2.0 or BSD'
  compatibility 'all'
  source_url 'https://github.com/dateutil/dateutil/releases/download/2.8.1/python-dateutil-2.8.1.tar.gz'
  source_sha256 '73ebfe9dbf22e832286dafa60473e4cd239f8592f699aa5adaf10050e6e1823c'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
