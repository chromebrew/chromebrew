require 'buildsystems/pip'

class Py3_urwid < Pip
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  version "4.0.13-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b1c848c8af1165c9b6860dab86b28a36283d26ce85f4e90edc63f4ef3729a625',
     armv7l: 'b1c848c8af1165c9b6860dab86b28a36283d26ce85f4e90edc63f4ef3729a625',
       i686: '0addaf348b20299bc74d74139ec74a83a3e57f34e8980aefb9e8db719f423bbf',
     x86_64: '2c588ecc336c620ffac403cbf9753b32d294ff89bca4ad199d7b74dd8178dc94'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :logical

  no_source_build
end
