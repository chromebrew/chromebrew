require 'buildsystems/pip'

class Py3_soupsieve < Pip
  description 'CSS selector library designed to be used with Beautiful Soup 4.'
  homepage 'https://github.com/facelessuser/soupsieve'
  version "2.9-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8450b0d44c240ff5588dba2f7b3912ba55e4a226f0ef71a0e490c009421dca86',
     armv7l: '8450b0d44c240ff5588dba2f7b3912ba55e4a226f0ef71a0e490c009421dca86',
       i686: 'b4b096ea49217852c3890bfec2259a840b30dfb8680415406f8ef555e1d6a60c',
     x86_64: 'c7168dabd7bd6f6b868eb1386407be1b078e78ca7cf205a7ab8823fdd9e97956'
  })

  depends_on 'python3' => :logical

  no_source_build
end
