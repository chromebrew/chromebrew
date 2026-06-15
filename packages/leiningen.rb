require 'package'

class Leiningen < Package
  description 'for automating Clojure projects without setting your hair on fire'
  homepage 'https://leiningen.org/'
  version '2.13.0'
  license 'EPL-1.0'
  compatibility 'all'
  source_url 'https://github.com/technomancy/leiningen.git'
  git_hashtag version

  depends_on 'clojure'

  no_compile_needed

  def self.patch
    # Correct the version.
    system "sed -i 's,2.12.1-SNAPSHOT,#{version},g' bin/lein"
  end

  def self.install
    FileUtils.install 'bin/lein', "#{CREW_DEST_PREFIX}/bin/lein", mode: 0o755
  end

  def self.postinstall
    downloader "https://github.com/technomancy/leiningen/releases/download/#{version}/leiningen-#{version}-standalone.jar",
               '5f5231f06c3c7924e3241e3dfa52885577fb44ddf8a9ea373d2c5e2f27217565'
    FileUtils.install "leiningen-#{version}-standalone.jar", "#{HOME}/.lein/self-installs/leiningen-#{version}-standalone.jar", mode: 0o644
    ExitMessage.add "\nType 'lein' to get started.\n"
  end

  def self.postremove
    Package.agree_to_remove("#{HOME}/.lein")
  end
end
