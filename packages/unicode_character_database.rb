require 'package'

class Unicode_character_database < Package
  description 'Unicode Character Database'
  homepage 'https://www.unicode.org/'
  version '17.0.0'
  license 'Unicode-DFS-2015'
  compatibility 'all'
  source_url "https://www.unicode.org/Public/#{version}/ucd/UCD.zip"
  source_sha256 '2066d1909b2ea93916ce092da1c0ee4808ea3ef8407c94b4f14f5b7eb263d28e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3f515f9085923b4a2f9b893d28ba4f520bbc53cab5a2b022b496bc92ea6beeea',
     armv7l: '3f515f9085923b4a2f9b893d28ba4f520bbc53cab5a2b022b496bc92ea6beeea',
       i686: '014ac64263ad7af3e986e1d342c3bcaaef2f51b27289b5a22004df8869ce5841',
     x86_64: 'b1bad61cfb583d168b3743c03e77081a24b8b0400df4c71ce2e6857314da3f09'
  })

  depends_on 'libarchive' => :build

  def self.build
    system "curl -Ls https://www.unicode.org/Public/#{version}/ucd/Unihan.zip| bsdtar --no-same-owner --no-same-permissions -xf -"
  end

  def self.install
    FileUtils.mkdir_p("#{CREW_DEST_PREFIX}/share/unicode")
    FileUtils.cp_r('.', "#{CREW_DEST_PREFIX}/share/unicode")
  end
end
