require 'package'

class Py3_mako < Package
  description 'Mako is a super fast templating language.'
  homepage 'https://www.makotemplates.org/'
  @_ver = '1.1.5'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/sqlalchemy/mako.git'
  git_hashtag "rel_#{@_ver.gsub('.', '_')}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_mako/1.1.5_armv7l/py3_mako-1.1.5-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_mako/1.1.5_armv7l/py3_mako-1.1.5-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_mako/1.1.5_i686/py3_mako-1.1.5-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_mako/1.1.5_x86_64/py3_mako-1.1.5-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'd87113392071930eaa7b0ba8aea2a52bcc1652a4ad49e966858e79b305416879',
     armv7l: 'd87113392071930eaa7b0ba8aea2a52bcc1652a4ad49e966858e79b305416879',
       i686: '97287f560d220954e690c87ad2642538520d226a1566fd0ff2b9cdaf281d78e9',
     x86_64: 'ca623e5a094c1a2a845a328549e7ffba65335bdb744df248288dc2a70960df0e'
  })

  depends_on 'py3_markupsafe'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
