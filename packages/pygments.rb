require 'package'

class Pygments < Package
  description 'Python Syntax Highlighter'
  homepage 'https://pygments.org/'
  version '2.7.3-1'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  def self.install
    system "pip3 install pygments --no-warn-script-location --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
