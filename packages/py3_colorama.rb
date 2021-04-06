require 'package'

class Py3_colorama < Package
  description 'Colorama makes ANSI escape character sequences work on Microsoft Windows.'
  homepage 'https://github.com/tartley/colorama/'
  version '0.4.4'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/tartley/colorama/archive/0.4.4.tar.gz'
  source_sha256 '78215866046cdc2cc00bf283e3dbff18b09840604534137f300a402afedf28e2'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
