require 'package'

class Kotlin < Package
  description 'Statically typed programming language for modern multiplatform applications'
  homepage 'https://kotlinlang.org/'
  version '1.2.21'
  source_url 'https://github.com/JetBrains/kotlin/releases/download/v1.2.21/kotlin-compiler-1.2.21.zip'
  source_sha256 'c5f2cbd35daa6c5c394e92e6c06b8eb41d85ad8da64762733874166b6807af22'

  depends_on 'jdk8'
  depends_on 'unzip' => :build

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_PREFIX}/share/kotlin"
    system "rm -f bin/*.bat"
    system "cp -r . #{CREW_DEST_PREFIX}/share/kotlin"
    FileUtils.cd("#{CREW_DEST_PREFIX}/share/kotlin/bin") do
      system "find . -type f -exec ln -s #{CREW_PREFIX}/share/kotlin/bin/{} #{CREW_DEST_PREFIX}/bin \\;"
    end
  end
end
