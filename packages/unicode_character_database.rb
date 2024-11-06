require 'package'

class Unicode_character_database < Package
  description 'Unicode Character Database'
  homepage 'https://www.unicode.org/'
  version '15.1.0'
  license 'Unicode-DFS-2015'
  compatibility 'all'
  source_url "https://www.unicode.org/Public/zipped/#{version}/UCD.zip"
  source_sha256 'cb1c663d053926500cd501229736045752713a066bd75802098598b7a7056177'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '26caf30c0bcfb89c007fcd11a12e7d45de7b9556f164af10e8278f11f35ca8fc',
     armv7l: '26caf30c0bcfb89c007fcd11a12e7d45de7b9556f164af10e8278f11f35ca8fc',
       i686: 'f5efedecde5ff06d53ab85291aad1e4df946f554261c11363e7b9b3f3a11d00d',
     x86_64: '319100958a2e3c1fbb4f31831632cf22e545b086a5a7e2afca1f2fc41db99291'
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
