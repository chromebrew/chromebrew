require 'package'

class Py3_minidb < Package
  description 'Minidb is a simple SQLite3-based store for Python objects'
  homepage 'https://thp.io/2010/minidb/'
  version '2.0.4'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/thp/minidb/archive/2.0.4.tar.gz'
  source_sha256 'f2554640be0c43a3cb6de48c82f3eb4ded507192257c9309a1a74ca92ddbaab2'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
