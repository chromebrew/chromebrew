require 'buildsystems/pip'

class Py3_markupsafe < Pip
  description 'Markupsafe allows the safe addition of untrusted strings to HTML/XML markup.'
  homepage 'https://markupsafe.palletsprojects.com/'
  version "3.0.4-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '378e03f9e12ea34a4a495c572a46f60faccec2cd2b3a2b708d04308b4c4878bf',
     armv7l: '378e03f9e12ea34a4a495c572a46f60faccec2cd2b3a2b708d04308b4c4878bf',
       i686: 'd2ebca655a3e90d363e7f2471ce2ab3da4a22938a733a93f8620166c074a42da',
     x86_64: '45a15628ebda47fab80626943897504d635fd325458b73ff511ed50abfdf50ec'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
