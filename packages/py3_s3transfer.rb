require 'buildsystems/pip'

class Py3_s3transfer < Pip
  description 'An Amazon S3 Transfer Manager'
  homepage 'https://github.com/boto/s3transfer'
  version "0.19.2-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '71eaed86b412af9d6f966c30c5964c68c655dae847d388625838096017462bc3',
     armv7l: '71eaed86b412af9d6f966c30c5964c68c655dae847d388625838096017462bc3',
       i686: '634f0907afb4747c05ff330bc248404641dea51c808e31cd25e6842ac2d4c615',
     x86_64: 'be1b2e5027a9b7050036e5c66707d6066d5fb377c8b4b832030ece59e174a2eb'
  })

  depends_on 'python3' => :logical

  no_source_build
end
