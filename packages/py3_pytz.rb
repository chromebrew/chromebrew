require 'buildsystems/pip'

class Py3_pytz < Pip
  description 'pytz brings the Olson tz database into Python.'
  homepage 'https://pythonhosted.org/pytz/'
  version "2026.6-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6f4637d910793bc1365fa7b403d4dac17d0095df4fbbc0251aca46e148816536',
     armv7l: '6f4637d910793bc1365fa7b403d4dac17d0095df4fbbc0251aca46e148816536',
       i686: '5f415477fa80ddff0fa94837e9d7fbb0256dea867b76b238a3b0962e44d9192e',
     x86_64: 'c99c2613816e3bf6649151b184009bd4a51a313d2df7f53d4ac73de8f72fbf14'
  })

  depends_on 'python3' => :logical

  no_source_build
end
