require 'buildsystems/pip'

class Py3_retrying < Pip
  description 'Retrying simplifies the task of adding retry behavior to just about anything.'
  homepage 'https://github.com/rholder/retrying/'
  version '1.3.4-py3.12'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aa834354a337faaebeecffd1ec60142310ad2336daab7349ffcdc7a8c819f186',
     armv7l: 'aa834354a337faaebeecffd1ec60142310ad2336daab7349ffcdc7a8c819f186',
       i686: '50b9012af35153ee4e57ed7654a4410c0e56e9538dba1c5b21295350baac45a9',
     x86_64: 'bace88257a27e476062fa937c00b503c2ae27cd337011d4f91a0030c8c070d75'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
