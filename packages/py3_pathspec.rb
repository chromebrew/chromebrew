require 'buildsystems/pip'

class Py3_pathspec < Pip
  description 'Path specification is a utility library for gitignore style pattern matching of file paths.'
  homepage 'https://github.com/cpburnz/python-pathspec'
  version "1.0.4-#{CREW_PY_VER}"
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4877209d3943142e6a3957e97400e99a2ef459809eb3d004082ad2b0975bbe19',
     armv7l: '4877209d3943142e6a3957e97400e99a2ef459809eb3d004082ad2b0975bbe19',
       i686: '7b899187ec60d4e4d80830d3a4989a20f1b239b4bc43a3761d308598ab11512f',
     x86_64: '6b52153c43affe56427c455b1ed665cd07459769ba25d5debbf7f0129a765ff5'
  })

  depends_on 'python3' => :build

  no_source_build
end
