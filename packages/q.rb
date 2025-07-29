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
     x86_64: '126b2ae1d134132be5e94963e286dc14c33c141bc68892614283f853851aa064'
  })

  depends_on 'python3'
end
