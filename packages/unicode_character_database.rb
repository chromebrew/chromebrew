require 'package'

class Unicode_character_database < Package
  description 'Unicode Character Database'
  homepage 'https://www.unicode.org/'
  version '18.0.0'
  license 'Unicode-DFS-2015'
  compatibility 'all'
  source_url "https://www.unicode.org/Public/#{version}/ucd/UCD.zip"
  source_sha256 '7b3e555514060b92290d154f53655c5eb0fa62b16eb04c03434ff72d1a66a0d8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '510e0d305b3fac043b15cbfc450d3173ac9a18f1de4c3572c1aa5a3629c1b8b6',
     armv7l: '510e0d305b3fac043b15cbfc450d3173ac9a18f1de4c3572c1aa5a3629c1b8b6',
       i686: 'af0be46bc7b9ea6bddaab66ac33ac5af658a01da0aae7144c31656a9ad8ef9b9',
     x86_64: '7f8e159365ef904887f5b2a4656c784a7831c8389db8d549a20ca34addacc3de'
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
