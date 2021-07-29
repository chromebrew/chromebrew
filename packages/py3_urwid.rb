require 'package'

class Py3_urwid < Package
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  @_ver = '2.1.2'
  version @_ver
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/urwid/urwid.git'
  git_hashtag "release-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_urwid/2.1.2_armv7l/py3_urwid-2.1.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_urwid/2.1.2_armv7l/py3_urwid-2.1.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_urwid/2.1.2_i686/py3_urwid-2.1.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_urwid/2.1.2_x86_64/py3_urwid-2.1.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '38afd9d587f8b96d22a0bee2dcb65733718c4cd5c22ce1aeaadc4184ab763d3b',
     armv7l: '38afd9d587f8b96d22a0bee2dcb65733718c4cd5c22ce1aeaadc4184ab763d3b',
       i686: '33e095941cac6e21c11f87cba6dd7f3729c985c168a4a88fa15162024171c2f1',
     x86_64: 'fa219fcf2872d1482f17fcee27f908e07dee4bcf2fdd9e7b0029e7075d650bee'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
