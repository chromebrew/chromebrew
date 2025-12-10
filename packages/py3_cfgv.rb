require 'buildsystems/pip'

class Py3_cfgv < Pip
  description 'Validate configuration and produce human readable error messages.'
  homepage 'https://github.com/asottile/cfgv'
  version "3.5.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '41afeb2361e43209c8b6ad928aaa0f0c4e3e3a096a8e1f9b8103e3591129f8ae',
     armv7l: '41afeb2361e43209c8b6ad928aaa0f0c4e3e3a096a8e1f9b8103e3591129f8ae',
       i686: '2805838e9bb7879f9630cd0cdea26b5d71458ecdbc285688b3b9f149e57af7f6',
     x86_64: '21dd30e371dbfda49ae840a55be4f1fafbce4e03233c54318fde1f512c87c94e'
  })

  depends_on 'python3' => :build

  no_source_build
end
