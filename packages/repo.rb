
require 'package'
 
class Repo < Package
  description 'Android Repo'
  homepage 'https://gerrit.googlesource.com/git-repo/'
  version '1.0'
  license 'Apache License 2'      
  compatibility 'x86_64' 
  source_url 'https://storage.googleapis.com/git-repo-downloads/repo'
  source_sha256 '974992a8bc1c787979f3eb7702a803b051deddc3cd75726c4de52e09e93b798d '

  depends_on 'gpgme'
  depends_on 'curl'
  depends_on 'python3'
  depends_on 'chromebeer'
 
  def self.preflight
    free_space = `echo $(($(stat -f --format="%a*%S" #{CREW_PREFIX})))`.chomp.to_i
    abort 'Not enough free disk space.  You need at least 1 MB to install.'.lightred if free_space < 1000000
 
  end

  def self.install
    FileUtils.install 'repo', "#{CREW_DEST_PREFIX}/bin/repo", mode: 0o755
    system("gpg --recv-key 8BB9AD793E8E6153AF0F9A4416530D5E920F5C65")
    system("chmod a+x $CREW_PREFIX/bin/repo")
 
  end
 
 

end
