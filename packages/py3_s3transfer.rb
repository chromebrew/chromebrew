require 'buildsystems/pip'

class Py3_s3transfer < Pip
  description 'An Amazon S3 Transfer Manager'
  homepage 'https://github.com/boto/s3transfer'
  version "0.18.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8059772deb45350fff9d9fca21e8f16191d8e19b60c3ba9d10d7ff730b8a552f',
     armv7l: '8059772deb45350fff9d9fca21e8f16191d8e19b60c3ba9d10d7ff730b8a552f',
       i686: '53b30e44d17d7d21ec63048020e5d49d7478f7dcc8bb4e9fe5f06e7d7746e341',
     x86_64: 'b304821b8ef996c06ebdd6a13b32c5e6008ff28cd29d44caf1bebc38f54c1521'
  })

  depends_on 'python3' => :logical

  no_source_build
end
