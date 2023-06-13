require 'package'

class Kotlin < Package
  description 'Statically typed programming language for modern multiplatform applications'
  homepage 'https://kotlinlang.org/'
  version '1.7.21'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/JetBrains/kotlin/releases/download/v1.7.21/kotlin-compiler-1.7.21.zip'
  source_sha256 '8412b31b808755f0c0d336dbb8c8443fa239bf32ddb3cdb81b305b25f0ad279e'

  depends_on 'openjdk8'

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/kotlin"
    FileUtils.rm_f 'bin/*.bat'
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/kotlin"
    Dir["#{CREW_DEST_PREFIX}/share/kotlin/bin/*"].each do |path|
      file = File.basename(path)
      FileUtils.ln_s "#{CREW_PREFIX}/share/kotlin/bin/#{file}", "#{CREW_DEST_PREFIX}/bin"
    end
  end
end
