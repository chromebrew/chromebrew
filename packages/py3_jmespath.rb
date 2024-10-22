require 'buildsystems/pip'

class Py3_jmespath < Pip
  description 'JMESPath is a query language for JSON.'
  homepage 'https://jmespath.org/'
  version "1.0.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3e02ccf73dd4c0d317e7bfba7671b20b474998dd6c72108a0947b2180f598bed',
     armv7l: '3e02ccf73dd4c0d317e7bfba7671b20b474998dd6c72108a0947b2180f598bed',
       i686: 'ae7fe2a6e34de4199c869f4ed3c1904e15ba66838b3d5b8cfa7edc04891602f0',
     x86_64: '499b831f9d349755d79d0def3294205981de911b14c47c229f7ad05fb729d2bb'
  })

  depends_on 'python3' => :build

  no_source_build
end
