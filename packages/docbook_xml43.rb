require 'package'

class Docbook_xml43 < Package
  description 'A widely used XML scheme for writing documentation and help'
  homepage 'https://www.oasis-open.org/docbook/'
  @_ver = '4.3'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url "https://docbook.org/xml/#{@_ver}/docbook-xml-#{@_ver}.zip"
  source_sha256 '23068a94ea6fd484b004c5a73ec36a66aa47ea8f0d6b62cc1695931f5c143464'

  depends_on 'docbook_xml'
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
        '#{CREW_PREFIX}/etc/xml/catalog'"

    system "xmlcatalog --noout --add \"delegatePublic\" \
        \"-//OASIS//DTD DocBook XML\" \
        \"file://#{CREW_PREFIX}/etc/xml/docbook-xml\" \
        '#{CREW_PREFIX}/etc/xml/catalog'"

    system "xmlcatalog --noout --add \"delegateSystem\" \
        \"http://www.oasis-open.org/docbook/\" \
        \"file://#{CREW_PREFIX}/etc/xml/docbook-xml\" \
        '#{CREW_PREFIX}/etc/xml/catalog'"

    system "xmlcatalog --noout --add \"delegateURI\" \
        \"http://www.oasis-open.org/docbook/\" \
        \"file://#{CREW_PREFIX}/etc/xml/docbook-xml\" \
        '#{CREW_PREFIX}/etc/xml/catalog'"
  end
end
