require 'package'

class Docbook_xml412 < Package
  description 'A widely used XML scheme for writing documentation and help'
  homepage 'https://www.oasis-open.org/docbook/'
  @_ver = '4.1.2'
  version @_ver
  compatibility 'all'
  source_url 'https://docbook.org/xml/4.1.2/docbkx412.zip'
  source_sha256 '30f0644064e0ea71751438251940b1431f46acada814a062870f486c772e7772'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xml412-4.1.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xml412-4.1.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xml412-4.1.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xml412-4.1.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '7a71988ef51b7480522c314559f76c3c9334c1a55f6981dcea536badafe3ffd9',
     armv7l: '7a71988ef51b7480522c314559f76c3c9334c1a55f6981dcea536badafe3ffd9',
       i686: 'a760d0c0a67601560012cc48bd88c5e45b853d6f8636a20ab8532729cbcfeb5b',
     x86_64: 'e61afc55e0d7d2e4b09df2185f64edb55e0cbea828fed2ac682906589911cfaf'
  })

  depends_on 'libxml2'
  depends_on 'xmlcatmgr'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/xml/docbook/xml-dtd-#{@_ver}"
    system "cp -dr docbook.cat *.dtd ent/ *.mod #{CREW_DEST_PREFIX}/share/xml/docbook/xml-dtd-#{@_ver}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/xml"
  end

  def self.preinstall
    # Docbook common preinstall block
    FileUtils.mkdir_p "#{CREW_PREFIX}/etc/xml"

    if File.exist?("#{CREW_PREFIX}/etc/xml/catalog") && !File.zero?("#{CREW_PREFIX}/etc/xml/catalog")
      puts "#{CREW_PREFIX}/etc/xml/catalog exists"
    else
      puts "Creating #{CREW_PREFIX}/etc/xml/catalog"
      FileUtils.rm_f "#{CREW_PREFIX}/etc/xml/catalog"
      system "xmlcatalog --noout --create #{CREW_PREFIX}/etc/xml/catalog"
    end

    if File.exist?("#{CREW_PREFIX}/etc/xml/docbook-xml") && !File.zero?("#{CREW_PREFIX}/etc/xml/docbook-xml")
      puts "#{CREW_PREFIX}/etc/xml/docbook-xml not empty"
    else
      puts "Creating #{CREW_PREFIX}/etc/xml/docbook-xml"
      FileUtils.rm_f "#{CREW_PREFIX}/etc/xml/docbook-xml"
      system "xmlcatalog --noout --create #{CREW_PREFIX}/etc/xml/docbook-xml"
    end
    # End Docbook common preinstall block
  end

  def self.postinstall
    # Docbook common postinstall block
    ENV['XML_CATALOG_FILES'] = "#{CREW_PREFIX}/etc/xml/catalog"

    xml_catalog_files_in_bashrc = `grep -c "XML_CATALOG_FILES" ~/.bashrc || true`
    unless xml_catalog_files_in_bashrc.to_i.positive?
      puts "Putting \"export XML_CATALOG_FILES=#{CREW_PREFIX}/etc/xml/catalog\" in ~/.bashrc".lightblue
      system "echo 'export XML_CATALOG_FILES=#{CREW_PREFIX}/etc/xml/catalog' >> ~/.bashrc"
      puts 'To complete the installation, execute the following:'.orange
      puts 'source ~/.bashrc'.orange
    end
    # End Docbook common postinstall block

    system "xmlcatalog --noout --add 'public' \
      '-//OASIS//DTD DocBook XML V#{@_ver}//EN' \
      'http://www.oasis-open.org/docbook/xml/#{@_ver}/docbookx.dtd' \
      '#{CREW_PREFIX}/etc/xml/docbook-xml'"
    system "xmlcatalog --noout --add 'public' \
      '-//OASIS//DTD DocBookXML CALS Table Model V#{@_ver}//EN' \
      'http://www.oasis-open.org/docbook/xml/#{@_ver}/calstblx.dtd' \
      '#{CREW_PREFIX}/etc/xml/docbook-xml'"
    system "xmlcatalog --noout --add 'public' \
      '-//OASIS//DTD XML Exchange Table Model 19990315//EN' \
      'http://www.oasis-open.org/docbook/xml/#{@_ver}/soextblx.dtd' \
      '#{CREW_PREFIX}/etc/xml/docbook-xml'"
    system "xmlcatalog --noout --add 'public' \
      '-//OASIS//ELEMENTS DocBookXML Information Pool V#{@_ver}//EN' \
      'http://www.oasis-open.org/docbook/xml/#{@_ver}/dbpoolx.mod' \
      '#{CREW_PREFIX}/etc/xml/docbook-xml'"
    system "xmlcatalog --noout --add 'public' \
      '-//OASIS//ELEMENTS DocBookXML Document Hierarchy V#{@_ver}//EN' \
      'http://www.oasis-open.org/docbook/xml/#{@_ver}/dbhierx.mod' \
      '#{CREW_PREFIX}/etc/xml/docbook-xml'"
    system "xmlcatalog --noout --add 'public' \
      '-//OASIS//ENTITIES DocBookXML Additional General Entities V#{@_ver}//EN' \
      'http://www.oasis-open.org/docbook/xml/#{@_ver}/dbgenent.mod' \
      '#{CREW_PREFIX}/etc/xml/docbook-xml'"
    system "xmlcatalog --noout --add 'public' \
      '-//OASIS//ENTITIES DocBookXML Notations V#{@_ver}//EN' \
      'http://www.oasis-open.org/docbook/xml/#{@_ver}/dbnotnx.mod' \
      '#{CREW_PREFIX}/etc/xml/docbook-xml'"
    system "xmlcatalog --noout --add 'public' \
      '-//OASIS//ENTITIES DocBookXML Character Entities V#{@_ver}//EN' \
      'http://www.oasis-open.org/docbook/xml/#{@_ver}/dbcentx.mod' \
      '#{CREW_PREFIX}/etc/xml/docbook-xml'"

    system "xmlcatalog --noout --add rewriteSystem \
      http://www.oasis-open.org/docbook/xml/#{@_ver} \
      #{CREW_PREFIX}/share/xml/docbook/xml-dtd-#{@_ver} \
      #{CREW_PREFIX}/etc/xml/docbook-xml"

    system "xmlcatalog --noout --add rewriteURI \
      http://www.oasis-open.org/docbook/xml/#{@_ver} \
      #{CREW_PREFIX}/share/xml/docbook/xml-dtd-#{@_ver} \
      #{CREW_PREFIX}/etc/xml/docbook-xml"

    system "xmlcatalog --noout --add 'public' \
      '-//OASIS//DTD DocBook XML V#{@_ver}//EN' \
      'http://www.oasis-open.org/docbook/xml/#{@_ver}/docbookx.dtd' \
      '#{CREW_PREFIX}/etc/xml/docbook-xml'"

    system "xmlcatalog --noout --add \"delegatePublic\" \
        \"-//OASIS//ENTITIES DocBook XML\" \
        \"file://#{CREW_PREFIX}/etc/xml/docbook-xml\" \
        #{CREW_PREFIX}/etc/xml/catalog"

    system "xmlcatalog --noout --add \"delegatePublic\" \
        \"-//OASIS//DTD DocBook XML\" \
        \"file://#{CREW_PREFIX}/etc/xml/docbook-xml\" \
        #{CREW_PREFIX}/etc/xml/catalog"

    system "xmlcatalog --noout --add \"delegateSystem\" \
        \"http://www.oasis-open.org/docbook/\" \
        \"file://#{CREW_PREFIX}/etc/xml/docbook-xml\" \
        #{CREW_PREFIX}/etc/xml/catalog"

    system "xmlcatalog --noout --add \"delegateURI\" \
        \"http://www.oasis-open.org/docbook/\" \
        \"file://#{CREW_PREFIX}/etc/xml/docbook-xml\" \
        #{CREW_PREFIX}/etc/xml/catalog"
  end
end
