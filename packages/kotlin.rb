require 'package'

class Kotlin < Package
  description 'Statically typed programming language for modern multiplatform applications'
  homepage 'https://kotlinlang.org/'
  version '1.1.61'
  source_url 'https://github.com/JetBrains/kotlin/releases/download/v1.1.61/kotlin-compiler-1.1.61.zip'
  source_sha256 '46103d3f65c4016cb62ff8b77ee3e072ff930e69edf69444d723bb22b12a0d83'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'jdk8'
  depends_on 'unzip' => :build

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_PREFIX}/share/kotlin"
    system "rm -f bin/*.bat"
    system "cp -r . #{CREW_DEST_PREFIX}/share/kotlin"
    FileUtils.cd("#{CREW_DEST_PREFIX}/share/kotlin/bin") do
      system "find . -exec ln -s #{CREW_PREFIX}/share/kotlin/bin/{} #{CREW_DEST_PREFIX}/bin \\;"
    end
  end
end
