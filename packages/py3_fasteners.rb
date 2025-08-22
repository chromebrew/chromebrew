require 'buildsystems/pip'

class Py3_fasteners < Pip
  description 'Fasteners provides useful locks for python programs.'
  homepage 'https://github.com/harlowja/fasteners/'
  version "0.20-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dd733b8a687bf1a7dcf06483e8f8abf57e04e761e3204fda8f51856c439726fe',
     armv7l: 'dd733b8a687bf1a7dcf06483e8f8abf57e04e761e3204fda8f51856c439726fe',
       i686: '835bbd7bab825d125dc8c78a1ec9d1b1ba7f8d01e03a43ded3def366ac83fed8',
     x86_64: '63e6377944d4db5a08bcc139f341ac1f35731489239dac818894fa5647346b0f'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
