require 'package'

class Leiningen < Package
  description 'for automating Clojure projects without setting your hair on fire'
  homepage 'https://leiningen.org/'
  version '2.9.1'
  compatibility 'all'
  source_url 'https://github.com/technomancy/leiningen/archive/2.9.1.tar.gz'
  source_sha256 'a4c239b407576f94e2fef5bfa107f0d3f97d0b19c253b08860d9609df4ab8b29'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'clojure'

  def self.install
    system "install -Dm755 bin/lein #{CREW_DEST_PREFIX}/bin/lein"
  end

  def self.postinstall
    puts
    puts "To start using leiningen, type 'lein'.".lightblue
    puts
    puts "To uninstall leiningen, execute the following:".lightblue
    puts "crew remove leiningen".lightblue
    puts "rm -rf ~/.lein".lightblue
    puts
  end
end
