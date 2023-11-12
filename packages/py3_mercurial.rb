require 'package'

class Mercurial < Package
  description 'Mercurial is a free, distributed source control management tool. It efficiently handles projects of any size and offers an easy and intuitive interface.'
  homepage 'https://www.mercurial-scm.org/'
  version '5.9.2'
  license 'GPL-2+'
  compatibility 'all'
  source_url "https://www.mercurial-scm.org/release/mercurial-#{version}.tar.gz"
  source_sha256 '1edad93096f64d5cae55b9550bb835ac73840c7406861c3cf4e14c3b443bec54'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mercurial/5.9.2_armv7l/mercurial-5.9.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mercurial/5.9.2_armv7l/mercurial-5.9.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mercurial/5.9.2_i686/mercurial-5.9.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mercurial/5.9.2_x86_64/mercurial-5.9.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '144612b4e724584a23ebc84bc456e253090931492a377d4502894f8b2f1b719f',
     armv7l: '144612b4e724584a23ebc84bc456e253090931492a377d4502894f8b2f1b719f',
       i686: 'bc14bb98c624fecbe3ad9f02135b9159bb36b2c79f89ff3ed2c1e381e1bc7c03',
     x86_64: '429d53235c70be2a251c2324982222b4836ed4fe15d912d86b577836655157ce'
  })

  depends_on 'py3_docutils'
  depends_on 'texinfo' => :build
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
