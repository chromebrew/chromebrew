require 'buildsystems/pip'

class Py3_pydf < Pip
  description 'Displays the amount of disk space available on the mounted filesystems, using different colours for different types of filesystems.'
  homepage 'https://github.com/garabik/pydf'
  version "12-#{CREW_PY_VER}"
  license 'BSD-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '98dacc9c63ac7748a590a85f9fd262443480459ad105a0594b5658470f70056d',
     armv7l: '98dacc9c63ac7748a590a85f9fd262443480459ad105a0594b5658470f70056d',
       i686: '668ac069f4b08722a586116c1b09ab9fbbb2e96dae53d7c7e78864348d34c150',
     x86_64: '736cfd6c5b6fcd8cfeca6053c09bffee0391a0b86bca63a0c27c4b4236752030'
  })

  depends_on 'python3' => :build

  no_source_build
end
