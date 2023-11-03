require 'buildsystems/pip'

class Py3_codespell < Pip
  description 'Fix common misspellings in text files.'
  homepage 'https://github.com/codespell-project/codespell'
  @_ver = '2.2.6'
  version "#{@_ver}-py3.12"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3'
  depends_on 'py3_ruff' # R

  no_compile_needed

  def self.remove
    @python_ver = "python#{`python3 -V`[/\d.\d+/]}"
    # Remove data, __pycache__ and tests directories.
    FileUtils.rm_rf "#{CREW_PREFIX}/lib/#{@python_ver}/site-packages/codespell_lib"
  end
end
