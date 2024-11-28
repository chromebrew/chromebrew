require 'buildsystems/pip'

class Py3_tomli < Pip
  description "Tomli is a lil' TOML parser."
  homepage 'https://github.com/hukkin/tomli/'
  version "2.2.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4ab9cc614472ee8991c3a237954cd77e368b177c5c35e5420f6f7924343bb7dc',
     armv7l: '4ab9cc614472ee8991c3a237954cd77e368b177c5c35e5420f6f7924343bb7dc',
       i686: 'e6bc6d30574430306d25723e58bfc342083d17da1027fc50792ec8238ddc7e6b',
     x86_64: 'a2b894aaa45b5d5fd55505af5214832ab28209dffbacb02d3af17ed3abb41780'
  })

  depends_on 'python3'
  depends_on 'py3_flit_core'
  depends_on 'glibc' # R

  no_source_build
end
