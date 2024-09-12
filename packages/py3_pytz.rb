require 'buildsystems/pip'

class Py3_pytz < Pip
  description 'pytz brings the Olson tz database into Python.'
  homepage 'https://pythonhosted.org/pytz/'
  version '2024.2-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '51257c0863afde906189d247cd6bbbb171ec9364eb631a563f28699f4869533f',
     armv7l: '51257c0863afde906189d247cd6bbbb171ec9364eb631a563f28699f4869533f',
       i686: 'bdd0620278075632f721c84a8520f3cfcedcdafa05c9a5d7d3861cf2c87f0482',
     x86_64: '4ae98539c11dc7f72b153c0791a363ca3281bf65e271ae7429a4bb86af333918'
  })

  depends_on 'python3' => :build

  no_source_build
end
