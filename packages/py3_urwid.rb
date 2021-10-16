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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_urwid/2.1.2_armv7l/py3_urwid-2.1.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_urwid/2.1.2_armv7l/py3_urwid-2.1.2-chromeos-armv7l.tpxz',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_urwid/2.1.2-1_x86_64/py3_urwid-2.1.2-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '38afd9d587f8b96d22a0bee2dcb65733718c4cd5c22ce1aeaadc4184ab763d3b',
     armv7l: '38afd9d587f8b96d22a0bee2dcb65733718c4cd5c22ce1aeaadc4184ab763d3b',
    x86_64: '973b6556c3bfb3a4f7b561e99c2f99e2a2190ecfb5631b4d4515eb4c3fdea760'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
