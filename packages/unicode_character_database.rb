require 'package'

class Unicode_character_database < Package
  description 'Unicode Character Database'
  homepage 'https://www.unicode.org/'
  @_ver = '13.0.0'
  version @_ver
  compatibility 'all'
  source_url "https://www.unicode.org/Public/zipped/#{@_ver}/UCD.zip"
  source_sha256 '2f76973b4d36ae45584f5a45ec65b47138932d777dd23a5669c89535ef3da951'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/unicode_character_database-13.0.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/unicode_character_database-13.0.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/unicode_character_database-13.0.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/unicode_character_database-13.0.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '68f18a9c671f5879fccebc536c730e28610eaa3b62615faac64c2aa240c0dfbe',
     armv7l: '68f18a9c671f5879fccebc536c730e28610eaa3b62615faac64c2aa240c0dfbe',
       i686: '95e4261e757d50b90268c50be6075c5bd339fc187fcda549d12bc953bc79b971',
     x86_64: '84dcb02569be48cedfbd149e8bd03507e66278615722a5f365b64a124c53a60b'
  })

  depends_on 'libarchive' => :build

  def self.build
    system "curl -Ls https://www.unicode.org/Public/zipped/#{@_ver}/Unihan.zip | bsdtar --no-same-owner --no-same-permissions -xf -"
  end

  def self.install
    FileUtils.mkdir_p("#{CREW_DEST_PREFIX}/share/unicode")
    FileUtils.cp_r('.', "#{CREW_DEST_PREFIX}/share/unicode")
  end
end
