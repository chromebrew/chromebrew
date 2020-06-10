require 'package'

class Kotlin < Package
  description 'Statically typed programming language for modern multiplatform applications'
  homepage 'https://kotlinlang.org/'
  version '1.2.21'
  compatibility 'all'
  source_url 'https://github.com/JetBrains/kotlin/releases/download/v1.2.21/kotlin-compiler-1.2.21.zip'
  source_sha256 'c5f2cbd35daa6c5c394e92e6c06b8eb41d85ad8da64762733874166b6807af22'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/kotlin-1.2.21-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/kotlin-1.2.21-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/kotlin-1.2.21-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/kotlin-1.2.21-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '580787afcc7ad7e021e0c966c46884202b4d670e1abbcdf111c7e81b35d19649',
     armv7l: '580787afcc7ad7e021e0c966c46884202b4d670e1abbcdf111c7e81b35d19649',
       i686: 'edee9e2ce58187e00ce0a25fe4feea860efbc86fb8e62c48f7cf4640ddc62780',
     x86_64: 'eb3b89c6bde5a07a7a4e32225c62dfb06a636e55ae640c3f35add313bedec5d0',
  })

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
