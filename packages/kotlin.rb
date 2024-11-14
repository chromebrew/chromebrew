require 'package'

class Kotlin < Package
  description 'Statically typed programming language for modern multiplatform applications'
  homepage 'https://kotlinlang.org/'
  version '2.0.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://github.com/JetBrains/kotlin/releases/download/v#{version}/kotlin-compiler-#{version}.zip"
  source_sha256 'ef578730976154fd2c5968d75af8c2703b3de84a78dffe913f670326e149da3b'

  depends_on 'openjdk8'

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/kotlin"
    FileUtils.rm_f Dir['bin/*.bat']
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/kotlin"
    Dir["#{CREW_DEST_PREFIX}/share/kotlin/bin/*"].each do |path|
      file = File.basename(path)
      FileUtils.ln_s "#{CREW_PREFIX}/share/kotlin/bin/#{file}", "#{CREW_DEST_PREFIX}/bin"
    end
  end
end
