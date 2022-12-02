require 'package'

class Py3_urwid < Package
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  @_ver = '2.1.2'
  version "#{@_ver}-py3.11"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/urwid/urwid.git'
  git_hashtag "release-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_urwid/2.1.2-py3.11_armv7l/py3_urwid-2.1.2-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_urwid/2.1.2-py3.11_armv7l/py3_urwid-2.1.2-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_urwid/2.1.2-py3.11_i686/py3_urwid-2.1.2-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_urwid/2.1.2-py3.11_x86_64/py3_urwid-2.1.2-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9b06f0b611fb348b04266d1718adb3f647179513688efc7eedd10f5707740ba4',
     armv7l: '9b06f0b611fb348b04266d1718adb3f647179513688efc7eedd10f5707740ba4',
       i686: '9bd10e9cea9f9ef6580a3e55975afd0bca2da02e0eb6b344b380dc792535130f',
     x86_64: 'a778ec1d7d65772e68a928444ead655f5fdf00ef3e67b7fc9a60e881c0d3b745'
  })

  depends_on 'python3' => :build
  depends_on 'glibc' # R

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
