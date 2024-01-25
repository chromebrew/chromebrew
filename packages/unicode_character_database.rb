require 'package'

class Unicode_character_database < Package
  description 'Unicode Character Database'
  homepage 'https://www.unicode.org/'
  version '13.0.0'
  license 'Unicode-DFS-2015'
  compatibility 'all'
  source_url "https://www.unicode.org/Public/zipped/#{version}/UCD.zip"
  source_sha256 '2f76973b4d36ae45584f5a45ec65b47138932d777dd23a5669c89535ef3da951'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '68f18a9c671f5879fccebc536c730e28610eaa3b62615faac64c2aa240c0dfbe',
     armv7l: '68f18a9c671f5879fccebc536c730e28610eaa3b62615faac64c2aa240c0dfbe',
       i686: '95e4261e757d50b90268c50be6075c5bd339fc187fcda549d12bc953bc79b971',
     x86_64: '84dcb02569be48cedfbd149e8bd03507e66278615722a5f365b64a124c53a60b'
  })

  depends_on 'libarchive' => :build

  def self.build
    system "curl -Ls https://www.unicode.org/Public/zipped/#{version}/Unihan.zip | bsdtar --no-same-owner --no-same-permissions -xf -"
  end

  def self.install
    FileUtils.mkdir_p("#{CREW_DEST_PREFIX}/share/unicode")
    FileUtils.cp_r('.', "#{CREW_DEST_PREFIX}/share/unicode")
  end
end
