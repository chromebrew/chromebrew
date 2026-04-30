require 'buildsystems/pip'

class Py3_s3transfer < Pip
  description 'An Amazon S3 Transfer Manager'
  homepage 'https://github.com/boto/s3transfer'
  version "0.17.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1d56c7a4f4e126330922fe2a3e5f622f56474455129bbdbe60727dde725f4bda',
     armv7l: '1d56c7a4f4e126330922fe2a3e5f622f56474455129bbdbe60727dde725f4bda',
       i686: 'ffa814511ac83b963e4fa2c289e57959ad9ca168c54b3dfa8aa0f326cae7b6e9',
     x86_64: '6ac5aa812e867742d3790a04a6979069b6e35e5d8682b94217726e333b79c720'
  })

  depends_on 'python3' => :logical

  no_source_build
end
