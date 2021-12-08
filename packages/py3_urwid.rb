require 'package'

class Py3_urwid < Package
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  @_ver = '2.1.2'
  version "#{@_ver}-1"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/urwid/urwid.git'
  git_hashtag "release-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_urwid/2.1.2-1_armv7l/py3_urwid-2.1.2-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_urwid/2.1.2-1_armv7l/py3_urwid-2.1.2-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_urwid/2.1.2-1_i686/py3_urwid-2.1.2-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_urwid/2.1.2-1_x86_64/py3_urwid-2.1.2-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '247a383b70411a76ceff0c110ba102ffdb779729d29a10fef0f55f5671e27a14',
     armv7l: '247a383b70411a76ceff0c110ba102ffdb779729d29a10fef0f55f5671e27a14',
       i686: '7b4a600226868fb8ae55d7264344bfbef39c40f7d20a539cfaf59dfb8e643edd',
     x86_64: '4f8d906ee631d3ba83673f6734e4ad2b9797b077e8bb65859380c0aaa06f9395'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
