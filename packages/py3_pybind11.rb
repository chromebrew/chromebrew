require 'buildsystems/pip'

class Py3_pybind11 < Pip
  description 'Seamless operability between C++11 and Python'
  homepage 'https://github.com/pybind/pybind11'
  version "2.13.6-#{CREW_PY_VER}"
  license 'BSD-3 Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '845870a92f25f1f508e24e2ff4a7f32ff9088638e96baca7da70514e699ab270',
     armv7l: '845870a92f25f1f508e24e2ff4a7f32ff9088638e96baca7da70514e699ab270',
       i686: 'd091ec27cd3bca95de8ef11ad2e82cc4f76c9a4c8d707dc6f8404603ae4ce482',
     x86_64: 'f99678f96b6acf10b91a26ff2db72c39d6d35e66255f788164ae86ef12c570bd'
  })

  depends_on 'python3'

  no_source_build
end
