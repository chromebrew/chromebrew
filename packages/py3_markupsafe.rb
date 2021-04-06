require 'package'

class Py3_markupsafe < Package
  description 'MarkupSafe escapes characters so text is safe to use in HTML and XML.'
  homepage 'https://markupsafe.palletsprojects.com/'
  version '1.1.1'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/pallets/markupsafe/archive/1.1.1.tar.gz'
  source_sha256 '222a10e3237d92a9cd45ed5ea882626bc72bc5e0264d3ed0f2c9129fa69fc167'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
