require 'buildsystems/pip'

class Py3_mercurial < Pip
  description 'Mercurial is a free, distributed source control management tool. It efficiently handles projects of any size and offers an easy and intuitive interface.'
  homepage 'https://www.mercurial-scm.org/'
  version "7.2.1-#{CREW_PY_VER}"
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f74333e0fcc8c460fb123f25e7d011a3e78879df4cc743d83fb32863d401e4ab',
     armv7l: 'f74333e0fcc8c460fb123f25e7d011a3e78879df4cc743d83fb32863d401e4ab',
     x86_64: '0a12ef6aaf21b55ccac0d7af67c4c4a661d5791bdfce0489b8b4a02ce03343f2'
  })

  depends_on 'buildessential' => :build
  depends_on 'glibc' => :library
  depends_on 'py3_docutils' => :build
  depends_on 'python3' => :logical
  depends_on 'texinfo' => :build

  no_source_build
end
