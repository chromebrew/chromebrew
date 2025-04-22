require 'package'

class Tldr < Package
  description 'A collection of simplified and community-driven man pages.'
  homepage 'https://tldr.sh/'
  version '35e652d'
  license 'MIT'
  compatibility 'all'
  source_url 'https://raw.githubusercontent.com/raylee/tldr-sh-client/35e652da07f57c2a44db1002d1d5e6bf4e23d9a9/tldr'
  source_sha256 'a8e7e2782fe81a1753ff2acdb502f98ba7ff3e7a95044d3efc114c27c57ad4f6'

  no_compile_needed

  def self.patch
    # Fix /usr/local/bin/tldr: 97: /usr/local/bin/tldr: cannot create /dev/stderr: Permission denied
    system "sed -i 's, > /dev/stderr,,g' tldr"
  end

  def self.install
    FileUtils.install 'tldr', "#{CREW_DEST_PREFIX}/bin/tldr", mode: 0o755
  end
end
