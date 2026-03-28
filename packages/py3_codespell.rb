require 'buildsystems/pip'

class Py3_codespell < Pip
  description 'Fix common misspellings in text files.'
  homepage 'https://github.com/codespell-project/codespell'
  version "2.4.2-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '956e1413f38db4fe7aa32aa3a72d9aa47e4a9cc33399ca05b144499660965c4b',
     armv7l: '956e1413f38db4fe7aa32aa3a72d9aa47e4a9cc33399ca05b144499660965c4b',
       i686: '243617f01d02c81d41a1a7c62971a6e677a7a63f7fa172848ba1e1c5937a3f93',
     x86_64: 'daeb0af269187cb056b01a90939ae06a3948612a07243313d838458698ac0fe1'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build

  def self.postremove
    @python_ver = "python#{`python3 -V`[/\d.\d+/]}"
    # Remove data, __pycache__ and tests directories.
    FileUtils.rm_rf "#{CREW_PREFIX}/lib/#{@python_ver}/site-packages/codespell_lib"
  end
end
