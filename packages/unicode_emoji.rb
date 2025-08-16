require 'package'

class Unicode_emoji < Package
  description 'Unicode Emoji Data Files'
  homepage 'https://www.unicode.org/emoji/'
  version '17.0'
  license 'unicode'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '41ac0040b8c5461b031dce29dd2edf65469c2a15d0d21935d6646dc676fcae01',
     armv7l: '41ac0040b8c5461b031dce29dd2edf65469c2a15d0d21935d6646dc676fcae01',
       i686: 'a18b4c80eb455a4c952b16420cf4a821c02202678b951aa83d72193f2f85c5d8',
     x86_64: 'a665707e091a39e72da8221c6d17b3d44973b5484c05b21c1451cc8970e1f2ae'
  })

  depends_on 'unicode_character_database' # L

  no_source_build

  def self.install
    FileUtils.mkdir_p("#{CREW_DEST_PREFIX}/share/unicode/emoji")
    system "curl -Lf https://www.unicode.org/Public/emoji/#{version}/emoji-sequences.txt -o #{CREW_DEST_PREFIX}/share/unicode/emoji/emoji-sequences.txt"
    system "curl -Lf https://www.unicode.org/Public/emoji/#{version}/emoji-test.txt -o #{CREW_DEST_PREFIX}/share/unicode/emoji/emoji-test.txt"
    system "curl -Lf https://www.unicode.org/Public/emoji/#{version}/emoji-zwj-sequences.txt -o #{CREW_DEST_PREFIX}/share/unicode/emoji/emoji-zwj-sequences.txt"
  end
end
