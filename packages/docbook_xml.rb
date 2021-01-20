require 'package'

class Docbook_xml < Package
  description 'Meta package for all versions of docbook_xml'
  compatibility 'all'
  homepage 'http://www.docbook.org'
  version '5.1-1'

  depends_on 'docbook_xml51'
  depends_on 'docbook_xml50'
  depends_on 'docbook_xml45'
  depends_on 'docbook_xml44'
  depends_on 'docbook_xml43'
  depends_on 'docbook_xml42'

  is_fake

end
