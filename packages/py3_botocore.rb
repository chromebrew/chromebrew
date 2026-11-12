require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.44.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b2848014fed7cca6507314a724e41c95c0b297a9e0ad17e6901c20c73e8e6fee',
     armv7l: 'b2848014fed7cca6507314a724e41c95c0b297a9e0ad17e6901c20c73e8e6fee',
       i686: '9e068f5b3722d6cb0c7868b8820b744344129eb7a2b71230ddb9b820bda77382',
     x86_64: '1d2380f5fb91e2184ed3ec2ca296e0a81f027ed7be96935b2b9335b83641f794'
  })

  depends_on 'python3' => :logical

  no_source_build
end
