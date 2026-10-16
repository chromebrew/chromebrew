require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.13.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd30770a517e2d380fb322bf399a25863d82e4c4205ac8d80290a8350ff9e1cea',
     armv7l: 'd30770a517e2d380fb322bf399a25863d82e4c4205ac8d80290a8350ff9e1cea',
       i686: '9891a025193ea3fd081bef61ff7065f15177450ec7377528640f5dbd2f752937',
     x86_64: 'a2b3f5dcbc8dcf1f98310f9d6d2947914480078bce699c4bd61d2bb82d6d4134'
  })

  depends_on 'python3' => :logical

  no_source_build
end
