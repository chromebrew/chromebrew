require 'package'

class Kotlin < Package
  description 'Statically typed programming language for modern multiplatform applications'
  homepage 'https://kotlinlang.org/'
  version '1.4.0'
  compatibility 'all'
  source_url 'https://github.com/JetBrains/kotlin/releases/download/v1.4.0/kotlin-compiler-1.4.0.zip'
  source_sha256 '590391d13b3c65ba52cba470f56efd5b14e2b1f5b9459f63aa12eb38ef52f161'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'jdk8'

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
