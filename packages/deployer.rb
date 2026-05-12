require 'package'

class Deployer < Package
  description 'A deployment tool for PHP'
  homepage 'https://deployer.org/'
  version '8.0.3'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/deployphp/deployer.git'
  git_hashtag "v#{version}"

  depends_on 'php84' unless File.exist? "#{CREW_PREFIX}/bin/php"
  depends_on 'composer' => :build

  no_compile_needed

  def self.install
    system 'composer install'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/deployer-#{version}"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/deployer-#{version}"
    FileUtils.ln_s "#{CREW_PREFIX}/share/deployer-#{version}/bin/build", "#{CREW_DEST_PREFIX}/bin/build"
    FileUtils.ln_s "#{CREW_PREFIX}/share/deployer-#{version}/bin/dep", "#{CREW_DEST_PREFIX}/bin/dep"
    FileUtils.ln_s "#{CREW_PREFIX}/share/deployer-#{version}/bin/docgen", "#{CREW_DEST_PREFIX}/bin/docgen"
  end

  def self.postinstall
    ExitMessage.add "\nType 'dep' to get started.\n"
  end
end
