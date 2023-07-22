require 'package'
 
class Repo < Package
  description 'The Multiple Git Repository Tool'
  homepage 'https://gerrit.googlesource.com/git-repo/'
  version '2.35'
  license 'Apache 2.0'
  compatibility 'x86_64'
  source_url 'https://gerrit.googlesource.com/git-repo.git'
  git_hashtag "v#{version}"

  depends_on 'python3'
 
  no_compile_needed

  def self.preflight
    free_space = `echo $(($(stat -f --format="%a*%S" #{CREW_PREFIX})))`.chomp.to_i
    abort 'Not enough free disk space.  You need at least 1 MB to install.'.lightred if free_space < 1000000
  end

  def self.install
    FileUtils.install 'repo', "#{CREW_DEST_PREFIX}/bin/repo", mode: 0o755
  end
end
