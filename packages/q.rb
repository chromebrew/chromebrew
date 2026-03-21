require 'buildsystems/python'

class Q < Python
  description 'SQL-like queries on tabular text data, including joins and subqueries'
  homepage 'https://github.com/harelba/q'
  version '3.1.7'
  license 'GPL3'
  compatibility 'x86_64'
  source_url 'https://github.com/harelba/q.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    x86_64: '4a9a576af685b838f26a8f90b84f2648ff660b097c451a1f28a42b4f0e890121'
  })

  depends_on 'python3' => :logical
end
