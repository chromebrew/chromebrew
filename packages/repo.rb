
require 'package'
 
class Repo < Package
  description 'Android Repo'
  version '2.32'
  license 'Apache License 2'      
  compatibility 'all' 
  source_url 'https://github.com/GerritCodeReview/git-repo.git'
  git_hashtag "v#{version}"
 
  depends_on 'python3'
 
  def self.preflight
    free_space = `echo $(($(stat -f --format="%a*%S" #{CREW_PREFIX})))`.chomp.to_i
    abort 'Not enough free disk space.  You need at least 1 MB to install.'.lightred if free_space < 1000000
 
  end

  def self.install
    FileUtils.install 'repo', "#{CREW_DEST_PREFIX}/bin/repo", mode: 0o755
  end
 
 

end
