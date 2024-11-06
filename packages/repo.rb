require 'package'
require 'misc_functions'

class Repo < Package
  description 'The Multiple Git Repository Tool'
  homepage 'https://gerrit.googlesource.com/git-repo/'
  version '2.45'
  license 'Apache 2.0'
  compatibility 'all'
  source_url 'https://gerrit.googlesource.com/git-repo.git'
  git_hashtag "v#{version}"

  depends_on 'python3'

  no_compile_needed

  def self.preflight
    MiscFunctions.check_free_disk_space(1000000000)
  end

  def self.install
    FileUtils.install 'repo', "#{CREW_DEST_PREFIX}/bin/repo", mode: 0o755
  end
end
