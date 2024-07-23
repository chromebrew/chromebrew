require 'package'

class Unicode_emoji < Package
  description 'Unicode Emoji Data Files'
  homepage 'https://www.unicode.org/emoji/'
  version '15.1'
  license 'unicode'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7319ad00966a207c407b54bce47d535fe9e69f8517d22c322a0362432eae5943',
     armv7l: '7319ad00966a207c407b54bce47d535fe9e69f8517d22c322a0362432eae5943',
       i686: '6b40a6d01b72043cc2fe03ad9f6a2b19a22416059ad1f13b3c9b9b4ea0b0d3f1',
     x86_64: 'da8877380b056175c61b7940022c4466a307e8b8cd46df6794166804b2fd4870'
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
