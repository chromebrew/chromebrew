require 'package'

class Bash_snippets < Package
  description 'A collection of small bash scripts for heavy terminal users'
  homepage 'https://github.com/alexanderepstein/Bash-Snippets'
  version '1.23.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/alexanderepstein/Bash-Snippets/archive/v1.23.0.tar.gz'
  source_sha256 '59b784e714ba34a847b6a6844ae1703f46db6f0a804c3e5f2de994bbe8ebe146'

  no_compile_needed

  def self.patch
    system "sed -i 's,prefix=\"/usr/local\",prefix=\"#{CREW_DEST_PREFIX}\",' install.sh"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1"
    system './install.sh all'
  end
end
