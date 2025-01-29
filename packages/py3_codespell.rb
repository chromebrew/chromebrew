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
    aarch64: '06dfcfc4e87832083ebf9ae2a12ec297baff8c6e201dbc9ff9da63fd9dea9bae',
     armv7l: '06dfcfc4e87832083ebf9ae2a12ec297baff8c6e201dbc9ff9da63fd9dea9bae',
       i686: '427dbe1020365dd4c966b735201e366ac07e0cc9a9276d8677487afc2b333caf',
     x86_64: '36a03cadae6e4eaa7e134d88dd0a0551d821198edc6572e226d30bebc0d1a749'
  })

  depends_on 'python3'

  no_source_build

  def self.postremove
    @python_ver = "python#{`python3 -V`[/\d.\d+/]}"
    # Remove data, __pycache__ and tests directories.
    FileUtils.rm_rf "#{CREW_PREFIX}/lib/#{@python_ver}/site-packages/codespell_lib"
  end
end
