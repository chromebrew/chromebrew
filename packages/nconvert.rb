require 'package'

class Nconvert < Package
  description 'Command Line Batch utility for images'
  homepage 'https://www.xnview.com/en/nconvert/'
  version '6.88'
  compatibility 'i686,x86_64'
  case ARCH
  when 'x86_64'
    source_url 'https://download.xnview.com/NConvert-linux64.tgz'
    source_sha256 '852c9cfefb92ea49670c8bc8fc4364297556066026b773321fe6b13718c57467'
  when 'i686'
    source_url 'https://download.xnview.com/NConvert-linux.tgz'
    source_sha256 '10f576609a982c9d7f4a519c9a49899609b63cea65d1a38b0c6f0c2fda2eb8c1'
  end

  def self.install
    system "install -Dm755 nconvert #{CREW_DEST_PREFIX}/bin/nconvert"
  end
end
