require 'buildsystems/pip'

class Py3_idna < Pip
  description 'IDNA provides internationalized domain names for Python.'
  homepage 'https://github.com/kjd/idna/'
  version '3.8-py3.12'
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '21b59ae57c31a3d748edeaecf79cd5d20257419e34d821c7525f995d971b7862',
     armv7l: '21b59ae57c31a3d748edeaecf79cd5d20257419e34d821c7525f995d971b7862',
       i686: '1dd5686f46aba9c74ca570d1a2acc9affa982b0ebec6d35adebb882f4be94705',
     x86_64: 'f0bad95f70351ef1418930d5c9c7e27c7edd8ae29bb480b17bdd31ca3d1bdb95'
  })

  depends_on 'python3' => :build

  no_source_build
end
