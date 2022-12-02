require 'package'

class Py3_mako < Package
  description 'Mako is a super fast templating language.'
  homepage 'https://www.makotemplates.org/'
  @_ver = '1.1.5'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/sqlalchemy/mako.git'
  git_hashtag "rel_#{@_ver.gsub('.', '_')}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_mako/1.1.5-py3.11_armv7l/py3_mako-1.1.5-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_mako/1.1.5-py3.11_armv7l/py3_mako-1.1.5-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_mako/1.1.5-py3.11_i686/py3_mako-1.1.5-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_mako/1.1.5-py3.11_x86_64/py3_mako-1.1.5-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd32d51a1af318181addb38a2ad21088f129ce1bb8f2e337bdd529e04ef33cd58',
     armv7l: 'd32d51a1af318181addb38a2ad21088f129ce1bb8f2e337bdd529e04ef33cd58',
       i686: '557c54246241748a66d88b77b199b5fa006012277dfeb537065b8a4279920906',
     x86_64: '7f5e5e4ab88d04f93a55cd57da556c25e641f274ccbe5089f004f49adda70384'
  })

  depends_on 'py3_markupsafe'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
