require 'buildsystems/pip'

class Py3_codespell < Pip
  description 'Fix common misspellings in text files.'
  homepage 'https://github.com/codespell-project/codespell'
  version "2.4.1-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '355c64aa91c78058612c960ca7df75c0c4061eb3f366c3d5619b92604a321be1',
     armv7l: '355c64aa91c78058612c960ca7df75c0c4061eb3f366c3d5619b92604a321be1',
       i686: '07cccdf520f21a6432092f399fe669cfd4cf28dd0633b669fa632b21c1f35d86',
     x86_64: '15b05cc886488ed2c56c66389299a5d49cb08f15d19ea7c6144043355a9160a2'
  })

  depends_on 'python3'

  no_source_build

  def self.postremove
    @python_ver = "python#{`python3 -V`[/\d.\d+/]}"
    # Remove data, __pycache__ and tests directories.
    FileUtils.rm_rf "#{CREW_PREFIX}/lib/#{@python_ver}/site-packages/codespell_lib"
  end
end
