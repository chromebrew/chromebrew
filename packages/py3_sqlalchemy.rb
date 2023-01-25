require 'package'

class Py3_sqlalchemy < Package
  description 'SQLalchemy is a database toolkit for Python.'
  homepage 'https://sqlalchemy.org'
  @_ver = '1.4.25'
  version "#{@_ver}-py3.11"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/sqlalchemy/sqlalchemy.git'
  git_hashtag "rel_#{@_ver.gsub('.', '_')}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sqlalchemy/1.4.25-py3.11_armv7l/py3_sqlalchemy-1.4.25-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sqlalchemy/1.4.25-py3.11_armv7l/py3_sqlalchemy-1.4.25-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sqlalchemy/1.4.25-py3.11_i686/py3_sqlalchemy-1.4.25-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sqlalchemy/1.4.25-py3.11_x86_64/py3_sqlalchemy-1.4.25-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5fb53ea0f20ce9c6782283f6777f75d1841226895b03022449d58262d3c8b62c',
     armv7l: '5fb53ea0f20ce9c6782283f6777f75d1841226895b03022449d58262d3c8b62c',
       i686: '189cab0f1852576b9fd7cae13c4288f5a2e580af5dbdcb71a4b1cc6ecd44fcac',
     x86_64: '942cdf21083e64bbf4d5bb4c83e29c9f931ebd0d161bd33fece8562be3dce47f'
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
