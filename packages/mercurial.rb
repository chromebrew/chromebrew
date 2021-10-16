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

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mercurial/5.8_armv7l/mercurial-5.8-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mercurial/5.8_armv7l/mercurial-5.8-chromeos-armv7l.tpxz',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mercurial/5.9.2_x86_64/mercurial-5.9.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '83b3a8bcd61c507ea89833c67966a36fd4d1f254cd294ef7025f67e5fe912451',
     armv7l: '83b3a8bcd61c507ea89833c67966a36fd4d1f254cd294ef7025f67e5fe912451',
    x86_64: '429d53235c70be2a251c2324982222b4836ed4fe15d912d86b577836655157ce'
  })

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
