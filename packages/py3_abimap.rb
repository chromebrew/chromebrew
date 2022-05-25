require 'buildsystems/python'

class Py3_abimap < Python
  description 'A helper for library maintainers to use symbol versioning'
  homepage 'https://github.com/ansasaki/abimap'
  @_ver = '0.3.2'
  version "#{@_ver}-py3.12"
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/ansasaki/abimap.git'
  git_hashtag "v#{@_ver}"
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_abimap/0.3.2-py3.12_armv7l/py3_abimap-0.3.2-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_abimap/0.3.2-py3.12_armv7l/py3_abimap-0.3.2-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_abimap/0.3.2-py3.12_i686/py3_abimap-0.3.2-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_abimap/0.3.2-py3.12_x86_64/py3_abimap-0.3.2-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2dfeb9e6b7ccb33314b37fa635b6abf3aa59f039005c90f1dcdaac1e811a92a6',
     armv7l: '2dfeb9e6b7ccb33314b37fa635b6abf3aa59f039005c90f1dcdaac1e811a92a6',
       i686: 'e04efd696ee2917057dc6dfdfd61c024f57cd53ead8957d3013f571bc9ef682a',
     x86_64: 'e8b783f82dc557620223d76c32ed1bd40950352da810664a99f312cddee683c9'
  })

  depends_on 'python3' => :build
end
