require 'package'

class Unicode_cldr < Package
  description 'Unicode Common Locale Data Repository'
  homepage 'https://cldr.unicode.org/'
  version '48-2'
  license 'unicode'
  compatibility 'all'
  source_url 'https://github.com/unicode-org/cldr.git'
  git_hashtag "release-#{version.gsub('.', '-')}"

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/unicode/cldr"
    FileUtils.cp_r 'common/', "#{CREW_DEST_PREFIX}/share/unicode/cldr"
  end
end
