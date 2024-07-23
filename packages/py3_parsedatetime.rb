require 'buildsystems/python'

class Py3_parsedatetime < Python
  description 'Parse human-readable date/time strings'
  homepage 'https://github.com/bear/parsedatetime/'
  @_ver = '2.6'
  version "#{@_ver}-py3.12"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/bear/parsedatetime.git'
  git_hashtag "v#{@_ver}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '89181ce08e4d0b1f963c3f468d664f105819a9f08ef54094c678eabff715d3dd',
     armv7l: '89181ce08e4d0b1f963c3f468d664f105819a9f08ef54094c678eabff715d3dd',
       i686: 'b90562fda1489f1da6233fba5f82b364c28e1ec528393a948f496a8d6db2a626',
     x86_64: 'aff1f75f1942c4e4e97c9abe51f06b97e0d00fc4509a2f4b26c02a60feff6af1'
  })

  depends_on 'python3' => :build
end
