require 'package'

class Kotlin < Package
  description 'Statically typed programming language for modern multiplatform applications'
  homepage 'https://kotlinlang.org/'
  version '1.9.24'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/JetBrains/kotlin/releases/download/v1.9.24/kotlin-compiler-1.9.24.zip'
  source_sha256 'eb7b68e01029fa67bc8d060ee54c12018f2c60ddc438cf21db14517229aa693b'

  depends_on 'openjdk8'

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/kotlin"
    FileUtils.rm_f Dir['bin/*.bat']
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/kotlin"
    Dir["#{CREW_DEST_PREFIX}/share/kotlin/bin/*"].each do |path|
      file = File.basename(path)
      FileUtils.ln_s "#{CREW_PREFIX}/share/kotlin/bin/#{file}", "#{CREW_DEST_PREFIX}/bin"
    end
  end
end
