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
    aarch64: '1d8655eaeb3fc144fd18b7e0a1cffafe0309ac112f0698845b27237a5c6fbe22',
     armv7l: '1d8655eaeb3fc144fd18b7e0a1cffafe0309ac112f0698845b27237a5c6fbe22',
       i686: '321cfe995ba2d2ee62f7657df2fd56d00a8e45d4d19a01c56d108708365b67f2',
     x86_64: 'bef1332d80100581c521ce78b2724aa0cea2b94535d4460326c446ad63b889ba'
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
