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
    aarch64: 'e483232123932b89a0a1d4a01b01aa3e815195a701a079ab531b29c90692da0a',
     armv7l: 'e483232123932b89a0a1d4a01b01aa3e815195a701a079ab531b29c90692da0a',
       i686: '4f2b45a9db7c1e0e2d28ed5912d3cfa304eff58c354530edcebf0f6a20759b29',
     x86_64: 'c1dd1f03f0316669d914b9117998df30f47075a7cc8fa362d6b98d4e68aabb48'
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
