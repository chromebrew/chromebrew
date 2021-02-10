require 'package'

class Docbook < Package
  description 'DocBook is an XML vocabulary that lets you create documents in a presentation-neutral form that captures the logical structure of your content.'
  homepage 'http://docbook.sourceforge.net/'
  version '1.79.1-2'
  compatibility 'all'
 
  is_fake

  depends_on 'docbook_xml'
  depends_on 'docbook_xsl'
  depends_on 'docbook_xsl_nons'
  
end
