require 'package'

class Pandoc < Package
  description 'Universal markup converter'
  homepage 'https://github.com/jgm/pandoc/'
  version '3.1.1'
  license 'GPL-2+'
  compatibility 'x86_64'
  source_url "https://github.com/jgm/pandoc/releases/download/#{version}/pandoc-#{version}-linux-amd64.tar.gz"
  source_sha256 '52b25f0115517e32047a06d821e63729108027bd06d9605fe8eac0fa83e0bf81'
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '623be2d8275ac435e0503fe68c3757829f8fffacca9d3079040c2170c27b01b9'
  })

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
    system "cp -r bin/ #{CREW_DEST_PREFIX}"
    system "cp -r share/ #{CREW_DEST_PREFIX}"
  end
end
