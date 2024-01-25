require 'package'

class Csvkit < Package
  description 'A suite of utilities for converting to and working with CSV, the king of tabular file formats.'
  homepage 'https://csvkit.rtfd.org/'
  @_ver = '1.0.6'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/wireservice/csvkit.git'
  git_hashtag @_ver
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: 'd994091e8c7a75c037341bf54a3c13026024465b0e4d511a911d06233c892fed',
     armv7l: 'd994091e8c7a75c037341bf54a3c13026024465b0e4d511a911d06233c892fed',
       i686: '3ceb3f1a108219dc06f1c8a75f859ffa59629385f779c0b47b9693dc78476123',
     x86_64: 'fe7412b386c56fd7db0dac7b7b60dcd342f84419324630775d3a841d32a90365'
  })

  depends_on 'py3_six'
  depends_on 'py3_agate_dfb'
  depends_on 'py3_agate'
  depends_on 'py3_agate_excel'
  depends_on 'py3_agate_sql'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
