require 'buildsystems/pip'

class Py3_agate < Pip
  description 'Agate is a data analysis library that is optimized for humans instead of machines.'
  homepage 'https://agate.readthedocs.io/'
  version "1.14.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7523329c84e6f4b6d4d5c393fb68e2b25364cfc769f141034d87fd116a343d10',
     armv7l: '7523329c84e6f4b6d4d5c393fb68e2b25364cfc769f141034d87fd116a343d10',
       i686: '06b91d2659938dbf2dd29e6c004b27e068f8468656a4f60d85f13e3e992ca33d',
     x86_64: 'dbf8b8c644eeb846bed94066fd4bf055c566d2c641f368e3e375b02a9db54726'
  })

  depends_on 'py3_babel'
  depends_on 'py3_six'
  depends_on 'py3_pyicu'
  depends_on 'py3_pytimeparse'
  depends_on 'py3_slugify'
  depends_on 'py3_isodate'
  depends_on 'py3_leather'
  depends_on 'py3_parsedatetime'
  depends_on 'python3' => :build

  no_source_build
end
