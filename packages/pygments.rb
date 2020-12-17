require 'package'

class Pygments < Package
  description 'Python Syntax Highlighter'
  homepage 'https://pygments.org/'
  version '2.7.3'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/29/60/8ff9dcb5eac7f4da327ba9ecb74e1ad783b2d32423c06ef599e48c79b1e1/Pygments-2.7.3.tar.gz'
  source_sha256 'ccf3acacf3782cbed4a989426012f1c535c9a90d3a7fc3f16d231b9372d2b716'


  def self.install
    system "pip3 install pygments --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
