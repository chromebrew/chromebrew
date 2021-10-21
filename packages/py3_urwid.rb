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
    aarch64: 'dfdae0b0d4159aa30ff5fd1ee9c446f6cd20a1446c20831887f2157f6aff023b',
     armv7l: 'dfdae0b0d4159aa30ff5fd1ee9c446f6cd20a1446c20831887f2157f6aff023b',
       i686: '11f19a599863208482874f880d6a2319f71496d606488c6105dbe9a88e5cb955',
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
