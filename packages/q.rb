# Adapted from Arch Linux q PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=q

require 'buildsystems/python'

class Q < Python
  description 'SQL-like queries on tabular text data, including joins and subqueries'
  homepage 'https://github.com/harelba/q'
  version '3.1.6'
  license 'GPL3'
  compatibility 'x86_64'
  source_url 'https://github.com/harelba/q.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '99544f65ac97a48e5f7e4c25eb26113db8301b25a5bbdd41d2fbfe52a5bdcd26'
  })

  depends_on 'python3'
end
