require 'package'

class Mercurial < Package
  description 'Mercurial is a free, distributed source control management tool. It efficiently handles projects of any size and offers an easy and intuitive interface.'
  homepage 'https://www.mercurial-scm.org/'
  @_ver = '5.9.2'
  version @_ver
  license 'GPL-2+'
  compatibility 'all'
  source_url "https://www.mercurial-scm.org/release/mercurial-#{@_ver}.tar.gz"
  source_sha256 '1edad93096f64d5cae55b9550bb835ac73840c7406861c3cf4e14c3b443bec54'

  depends_on 'py3_docutils'
  depends_on 'texinfo' => :build
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
