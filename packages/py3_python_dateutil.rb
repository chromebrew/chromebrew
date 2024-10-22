require 'buildsystems/pip'

class Py3_python_dateutil < Pip
  description 'Dateutil provides extensions to the standard Python datetime module.'
  homepage 'https://dateutil.readthedocs.io/'
  version "2.9.0.post0-#{CREW_PY_VER}"
  license 'BSD-3 and Apache-2.0 or BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ad23fca01877063d09491313935eda671c202d7b961d6e8e84899ee0d90336ef',
     armv7l: 'ad23fca01877063d09491313935eda671c202d7b961d6e8e84899ee0d90336ef',
       i686: '5a0abeaabb5acaf0476715c06932798a7ab5d9f4fb7b9b75b26e3621320e98a5',
     x86_64: 'd1729d6c9daf3e3e5f6ea13bc86e332b417835c6f934ce7ebe91fb50154cb5aa'
  })

  depends_on 'python3' => :build

  no_source_build
end
