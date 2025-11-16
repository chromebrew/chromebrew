require 'buildsystems/python'

class Gyp_next < Python
  description 'GYP is a fork of the GYP build system for use in the Node.js projects.'
  homepage 'https://github.com/nodejs/gyp-next/'
  version '0.21.0'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/nodejs/gyp-next.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aaa4754161030d45808f5d6d9e8084cfd2bd44f2b07922fa156b83888e23150e',
     armv7l: 'aaa4754161030d45808f5d6d9e8084cfd2bd44f2b07922fa156b83888e23150e',
       i686: '86c9e2f8c7c7b74789b7348720a1afd5db0a157f40782aab0477137dd99bccaa',
     x86_64: 'd81b4a63056e5e274c5ed6132a4a93c3a3b3425c89df52db465755edb16f1a5e'
  })

  depends_on 'python3' => :build
end
