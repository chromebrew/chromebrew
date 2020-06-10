require 'package'

class Hugo < Package
  description 'Hugo is one of the most popular open-source static site generators.'
  homepage 'https://gohugo.io'
  version '0.70.0'
  compatibility 'all'

  case ARCH
  when 'aarch64','armv7l'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.70.0/hugo_0.70.0_Linux-ARM.tar.gz'
    source_sha256 '7891baefe1845ea8ff03ca2f0589305b526a60f4ee4acbf556f4c180d8e8859f'
  when 'i686'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.70.0/hugo_0.70.0_Linux-32bit.tar.gz'
    source_sha256 '5c7c530ab9be86ca90a3f5d5a583ac55d7b2e7a59471188c0eb58113e1476ffd'
  when 'x86_64'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.70.0/hugo_0.70.0_Linux-64bit.tar.gz'
    source_sha256 'd0e2e1f8d2f69c1b378e34daaf9f91997cf777d3151da4d8aa6bd7b5703f9446'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system "install -Dm755 hugo #{CREW_DEST_PREFIX}/bin/hugo"
  end
end
