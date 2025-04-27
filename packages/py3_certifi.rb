require 'buildsystems/pip'

class Py3_certifi < Pip
  description 'Certifi provides Mozilla\'s CA Bundle.'
  homepage 'https://certifi.io/'
  version "2025.4.26-#{CREW_PY_VER}"
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'be0d329b99cfac5be1cb1790c3f6b63735fd44a281834e030c3c855103b1a32d',
     armv7l: 'be0d329b99cfac5be1cb1790c3f6b63735fd44a281834e030c3c855103b1a32d',
       i686: 'cccb82d2fce88bd04c774486a549acfae17414bcc9c7a1eb8d4f554c71820a8e',
     x86_64: '94079e52375576a5fed9b798ec3eb927167b62acc798cc838f4dae2445a5ebba'
  })

  depends_on 'python3' # L

  no_source_build
end
