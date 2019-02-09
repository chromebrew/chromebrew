require 'package'

class Cloc < Package
  description 'cloc counts blank lines, comment lines, and physical lines of source code in many programming languages.'
  homepage 'https://github.com/AlDanial/cloc'
  version '1.80'
  source_url 'https://github.com/AlDanial/cloc/releases/download/1.80/cloc-1.80.tar.gz'
  source_sha256 '082f53530eee3f9ee84ec449eca59a77ff114250cd7daf9519679537b5b21d67'

  def self.install
    system "install -Dm755 cloc #{CREW_DEST_PREFIX}/bin/cloc"
  end
end
