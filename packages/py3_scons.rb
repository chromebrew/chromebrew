require 'buildsystems/pip'

class Py3_scons < Pip
  description 'SCons is an Open Source software construction tool that is, a next-generation build tool.'
  homepage 'https://scons.org/'
  license 'MIT'
  version '4.10.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f57531bdcc0b6525ba7f681cfb06932a6885c468a3ccf04cb45d29b63ea2c621',
     armv7l: 'f57531bdcc0b6525ba7f681cfb06932a6885c468a3ccf04cb45d29b63ea2c621',
       i686: '0eeec458006b2775b6c6e9e5dc0f0f50bc8c41ab4e475beb86924e1f6f92216c',
     x86_64: 'd432d9de96ff40a2ea874ecd521382657a89cf6f457fe99f2b2bca6f865c69df'
  })

  depends_on 'python3' # R
  no_source_build
end
