require 'buildsystems/pip'

class Py3_setuptools_scm < Pip
  description 'Setuptools-scm is the blessed package to manage your versions by scm tags.'
  homepage 'https://github.com/pypa/setuptools_scm'
  version "10.2.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '78d5096bc1f1f8673da810ad9415cfcd6c42f49d6737b060e0a9010e83ef61a2',
     armv7l: '78d5096bc1f1f8673da810ad9415cfcd6c42f49d6737b060e0a9010e83ef61a2',
       i686: 'b4ef2403022374ef2f3827ce605abdc0f33f732765f4818e0bc17201511f4ea8',
     x86_64: 'a2d01962a3e73e7a146ac99c46ca65c82a3af9f237902207e70e8604748ded51'
  })

  depends_on 'py3_packaging'
  depends_on 'py3_tomli'
  depends_on 'python3' => :logical

  no_source_build
end
