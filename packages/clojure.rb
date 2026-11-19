require 'package'

class Clojure < Package
  description 'Clojure is a robust, practical, and fast programming language with a set of useful features that together form a simple, coherent, and powerful tool.'
  homepage 'https://clojure.org/'
  version '1.12.7'
  license 'EPL-1.0, Apache-2.0 and BSD'
  compatibility 'all'
  source_url 'https://github.com/clojure/clojure.git'
  git_hashtag "clojure-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e7da80729fc884324deb780f82eacd9e470599c9856456e52034c923cfdb4626',
     armv7l: 'e7da80729fc884324deb780f82eacd9e470599c9856456e52034c923cfdb4626',
       i686: '2cc8004b94c127cedfda9aa606596570c9b2749707f05b782bdc16be80a3a872',
     x86_64: 'be3f4a06f583d907fbb720991fc21a9ab4cc7ec7bff63b11ba138bb80a815af6'
  })

  depends_on 'ant' => :build
  depends_on 'maven' => :build
  depends_on 'openjdk17' # R
  depends_on 'rlwrap' # R

  def self.build
    ENV['JAVA_HOME'] = CREW_PREFIX
    File.write 'clojure.sh', <<~EOF
      #!/bin/bash
      java -jar #{CREW_PREFIX}/share/clojure/clojure.jar "$@"
    EOF
    system './antsetup.sh'
    system 'ant local'
  end

  def self.install
    FileUtils.install 'clojure.sh', "#{CREW_DEST_PREFIX}/bin/clojure", mode: 0o755
    FileUtils.install 'clojure.jar', "#{CREW_DEST_PREFIX}/share/clojure/clojure.jar", mode: 0o644
  end
end
