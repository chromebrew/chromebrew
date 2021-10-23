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
    aarch64: '4270ff224fb115ac320eceacdcd04023abb91eefc520567ba7bb186319d0e2e5',
     armv7l: '4270ff224fb115ac320eceacdcd04023abb91eefc520567ba7bb186319d0e2e5',
       i686: '5698d31b7407f654e2fb21a51df9f8d88b3ebf95a1cef7ee5b9ac994915e151f',
     x86_64: 'f6df66da77134825fc72ab86b0855ec33b943c109df93526295b333f1962a668'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
