require 'buildsystems/pip'

class Py3_pyxdg < Pip
  description 'PyXDG contains implementations of freedesktop.org standards in python.'
  homepage 'https://freedesktop.org/wiki/Software/pyxdg/'
  version "0.28-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b95b0f518267c116ec7726ae7379ef8b701ca96e89060db731e4b1ab27650ba9',
     armv7l: 'b95b0f518267c116ec7726ae7379ef8b701ca96e89060db731e4b1ab27650ba9',
       i686: '8aa3f88171fa0c1dab857f60c815c018a5f1a7b247fb54828a97ace738663d4d',
     x86_64: '7c36f4e14291a24980878e9cef5b5dd14e0b9f087e6ce6f73d1c0d51c636d858'
  })

  depends_on 'python3' => :build

  no_source_build
end
