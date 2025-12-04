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
    aarch64: '9e882262804afff944352427b799a45c31e2d6641f47725c68b464d42eabc05b',
     armv7l: '9e882262804afff944352427b799a45c31e2d6641f47725c68b464d42eabc05b',
       i686: '6d4720b75f2b88a36966d6a6a5d60296b9c7e9ca90ab705a91f244f13eb0fbe4',
     x86_64: '65fe32a9c9137514c7ecb6041e3b7db825d2cfa972beb2851caa950059119cda'
  })

  depends_on 'python3'

  no_source_build

  def self.postremove
    @python_ver = "python#{`python3 -V`[/\d.\d+/]}"
    # Remove data, __pycache__ and tests directories.
    FileUtils.rm_rf "#{CREW_PREFIX}/lib/#{@python_ver}/site-packages/codespell_lib"
  end
end
