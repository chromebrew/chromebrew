require 'package'

class Py3_agate_dfb < Package
  description 'Agate-dbf adds read support for DBF files to agate.'
  homepage 'https://agate-dbf.readthedocs.org/'
  @_ver = '0.2.2'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/wireservice/agate-dbf.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_dfb/0.2.2-py3.11_armv7l/py3_agate_dfb-0.2.2-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_dfb/0.2.2-py3.11_armv7l/py3_agate_dfb-0.2.2-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_dfb/0.2.2-py3.11_i686/py3_agate_dfb-0.2.2-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_agate_dfb/0.2.2-py3.11_x86_64/py3_agate_dfb-0.2.2-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '69d49672d88b941fd09d0395af298ffbaecd500db6793ede0dbf8a1559d80d4e',
     armv7l: '69d49672d88b941fd09d0395af298ffbaecd500db6793ede0dbf8a1559d80d4e',
       i686: 'f1d642fea25c00c74b1b1bc4f532e002c1e5f7f6c0be8189ef7715f3612c046d',
     x86_64: '0407540c4d2412e01ff9cb3b5ad15ac9dba5100f55b4055cd49cdd969a26f5eb'
  })

  depends_on 'py3_dbfread'
  depends_on 'py3_agate'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
