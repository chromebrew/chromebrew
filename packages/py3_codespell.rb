require 'buildsystems/pip'

class Py3_codespell < Pip
  description 'Fix common misspellings in text files.'
  homepage 'https://github.com/codespell-project/codespell'
  version "2.4.3-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '93d437585cd22122d0113bea832027786505648efe3d59ab3ed6d30276e032fe',
     armv7l: '93d437585cd22122d0113bea832027786505648efe3d59ab3ed6d30276e032fe',
       i686: '0bcc46d8ceb3ee1689dff7359288aacff3824fbd0f33dfe4592359e09d1528d1',
     x86_64: '8a201a59fe834622a9e047ede904f81adcb7b157ed39513f27271a39242b8a98'
  })

  depends_on 'python3' => :logical

  no_source_build

  def self.postremove
    @python_ver = "python#{`python3 -V`[/\d.\d+/]}"
    # Remove data, __pycache__ and tests directories.
    FileUtils.rm_rf "#{CREW_PREFIX}/lib/#{@python_ver}/site-packages/codespell_lib"
  end
end
