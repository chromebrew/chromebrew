require 'package'

class Itstool < Package
  description 'Translate XML with PO files using W3C Internationalization Tag Set rules'
  homepage 'http://itstool.org/'
  version '2.0.4'
  source_url 'https://github.com/itstool/itstool/archive/2.0.4.tar.gz'
  source_sha256 '3221bba908eb3c19d3b6f8e195ad706afcfef9d2f552d44e45cd77f622fd6dbc'

  depends_on 'python27'

  def self.install
    system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} itstool"
  end
end
