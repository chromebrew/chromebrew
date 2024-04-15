require 'package'

class Unicode_cldr < Package
  description 'Unicode Common Locale Data Repository'
  homepage 'http://cldr.unicode.org/'
  version '44.1'
  license 'unicode'
  compatibility 'all'
  source_url 'https://github.com/unicode-org/cldr.git'
  git_hashtag "release-#{version.gsub('.', '-')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7a52d10bbb77701f6bf1b00a415fed9d47a2595b2ece834483cdc5077b7ecae1',
     armv7l: '7a52d10bbb77701f6bf1b00a415fed9d47a2595b2ece834483cdc5077b7ecae1',
       i686: 'd26796782ddb30696d6efb3e426afbfe5f2f5f789db94181eb4f04e033fc7f61',
     x86_64: '1a27f4c1ab88f460fe9786ec33abb79d00aa5be5573aa46bcf73a354d9647c7d'
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/unicode/cldr"
    FileUtils.cp_r 'common/', "#{CREW_DEST_PREFIX}/share/unicode/cldr"
  end
end
