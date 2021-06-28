require 'package'

class Kotlin < Package
  description 'Statically typed programming language for modern multiplatform applications'
  homepage 'https://kotlinlang.org/'
  version '1.5.20'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/JetBrains/kotlin/releases/download/v1.5.20/kotlin-compiler-1.5.20.zip'
  source_sha256 'edf34263ddaabd48f7ec59661e4c0d1dc868462fd3a1ea323083d0e3e83a8a8b'

  depends_on 'jdk8'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/kotlin"
    FileUtils.rm_f Dir['bin/*.bat']
    FileUtils.mv Dir['.'] "#{CREW_DEST_PREFIX}/share/kotlin"
    FileUtils.cd "#{CREW_DEST_PREFIX}/share/kotlin/bin" do
      system "find . -type f -exec ln -s #{CREW_PREFIX}/share/kotlin/bin/{} #{CREW_DEST_PREFIX}/bin \\;"
    end
  end
end
