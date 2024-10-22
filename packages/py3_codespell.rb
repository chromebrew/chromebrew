require 'buildsystems/pip'

class Py3_codespell < Pip
  description 'Fix common misspellings in text files.'
  homepage 'https://github.com/codespell-project/codespell'
  version "2.3.0-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5e9b610a7825e10c1e03572e9fc12dfceb0872625a86b1ac39a6496a7b4a3c9b',
     armv7l: '5e9b610a7825e10c1e03572e9fc12dfceb0872625a86b1ac39a6496a7b4a3c9b',
       i686: '096ed746f41f4a49e0e3705974cad3f4fe8318a6524a33703f6c081de60a85ed',
     x86_64: 'b0185823f5117581a7a6911ff564e238e04141fdb4833a7f3791bfd5818c38fa'
  })

  depends_on 'python3'

  no_source_build

  def self.postremove
    @python_ver = "python#{`python3 -V`[/\d.\d+/]}"
    # Remove data, __pycache__ and tests directories.
    FileUtils.rm_rf "#{CREW_PREFIX}/lib/#{@python_ver}/site-packages/codespell_lib"
  end
end
