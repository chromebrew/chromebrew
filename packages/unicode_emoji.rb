require 'package'

class Unicode_emoji < Package
  description 'Unicode Emoji Data Files'
  homepage 'https://www.unicode.org/emoji/'
  version '13.1'
  license 'unicode'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '9829b6a211e83f87db2d57bd1acb7c27fc9617f0eba167555813775de0aea844',
     armv7l: '9829b6a211e83f87db2d57bd1acb7c27fc9617f0eba167555813775de0aea844',
       i686: '893e3b5b6463a2806339f16e0a44ffa41edad6a31cb8fc8b3ad8b7170fd85042',
     x86_64: '7082341530a8b5d27dda94db2ec5cfec2e4d7f5448b50bdd0ac351126f925843'
  })

  depends_on 'unicode_character_database'

  def self.install
    FileUtils.mkdir_p("#{CREW_DEST_PREFIX}/share/unicode/emoji")
    system "curl -Lf https://www.unicode.org/Public/emoji/#{version}/emoji-sequences.txt -o #{CREW_DEST_PREFIX}/share/unicode/emoji/emoji-sequences.txt"
    system "curl -Lf https://www.unicode.org/Public/emoji/#{version}/emoji-test.txt -o #{CREW_DEST_PREFIX}/share/unicode/emoji/emoji-test.txt"
    system "curl -Lf https://www.unicode.org/Public/emoji/#{version}/emoji-zwj-sequences.txt -o #{CREW_DEST_PREFIX}/share/unicode/emoji/emoji-zwj-sequences.txt"
  end
end
