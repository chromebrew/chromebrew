require 'buildsystems/python'

class Py3_sqlalchemy < Python
  description 'SQLalchemy is a database toolkit for Python.'
  homepage 'https://sqlalchemy.org'
  @_ver = '2.0.21'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/sqlalchemy/sqlalchemy.git'
  git_hashtag "rel_#{@_ver.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c534589d8b157fcf9ea4b9e271b4b84308a1c030738e2c2990a150a19079015f',
     armv7l: 'c534589d8b157fcf9ea4b9e271b4b84308a1c030738e2c2990a150a19079015f',
       i686: 'a2a0947a8e18772bcc0c68caf51ff8d0c4f2105b36164146b2fdc5bc20282736',
     x86_64: '1b9a83282c33ec27d911cbff1df78c84cfe5e2bffb55e6b51b51ed880906c233'
  })

  depends_on 'python3' => :build
  depends_on 'glibc' # R
end
