require 'package'

class Py3_urwid < Package
  description 'Urwid is a console user interface library for Python.'
  homepage 'http://urwid.org/'
  version '2.1.2'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/urwid/urwid/archive/release-2.1.2.tar.gz'
  source_sha256 '366970cabce4a7f70fb4af1d16ac8be23dbcf38f995a20029a4bf32fffe7607d'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
