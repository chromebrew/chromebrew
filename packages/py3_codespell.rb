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
    aarch64: 'f8531a98bb6b17d667d2ebba853b2ad5b75cbed54a36d749e6067864e9ea38b3',
     armv7l: 'f8531a98bb6b17d667d2ebba853b2ad5b75cbed54a36d749e6067864e9ea38b3',
       i686: '250222ce23028fb48b0b8787bb4722f4460675bc54a2e6e7ab514c1fe03e9544',
     x86_64: '8fd54c0f3e427e4b979a0607e86b5abbb128f842d821f96dc7a0ae75cf00345a'
  })

  depends_on 'python3'

  no_source_build

  def self.postremove
    @python_ver = "python#{`python3 -V`[/\d.\d+/]}"
    # Remove data, __pycache__ and tests directories.
    FileUtils.rm_rf "#{CREW_PREFIX}/lib/#{@python_ver}/site-packages/codespell_lib"
  end
end
