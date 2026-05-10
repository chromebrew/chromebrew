require 'buildsystems/pip'

class Py3_parsedatetime < Pip
  description 'Parse human-readable date/time strings'
  homepage 'https://github.com/bear/parsedatetime/'
  version "2.6-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7babfabc7f582462e1e1f1200534484db1014ac8d56556991d65a946ff8a5b09',
     armv7l: '7babfabc7f582462e1e1f1200534484db1014ac8d56556991d65a946ff8a5b09',
       i686: '051f5ead957ecf5f6b632e60e6613bd4fba3aec06512fab1532f0f1b11b87387',
     x86_64: '7faa12c4d2b560c6e521d54e033424ff31107ad6673abfa1da50fb8846d4e427'
  })

  depends_on 'python3' => :logical

  no_source_build
end
