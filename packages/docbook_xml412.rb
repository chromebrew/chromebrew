require 'package'

class Docbook_xml412 < Package
  description 'A widely used XML scheme for writing documentation and help'
  homepage 'https://www.oasis-open.org/docbook/'
  @_ver = '4.1.2'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://docbook.org/xml/4.1.2/docbkx412.zip'
  source_sha256 '30f0644064e0ea71751438251940b1431f46acada814a062870f486c772e7772'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/docbook_xml412/4.1.2-1_armv7l/docbook_xml412-4.1.2-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/docbook_xml412/4.1.2-1_armv7l/docbook_xml412-4.1.2-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/docbook_xml412/4.1.2-1_i686/docbook_xml412-4.1.2-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/docbook_xml412/4.1.2-1_x86_64/docbook_xml412-4.1.2-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'e7b80341f9c8c4c84e5064785e21a7f4b28966abc09447763343d34af6f92203',
     armv7l: 'e7b80341f9c8c4c84e5064785e21a7f4b28966abc09447763343d34af6f92203',
       i686: '322606e25ce187ed1b62573e4c4e51dda56054c4bf48d635fc126ed82f13a5f2',
     x86_64: 'ece6d95295cd269780339a9dca5925b224f63cf01879a1a27370faf7d13a4648'
  })

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

    if File.exist?("#{CREW_PREFIX}/etc/xml/catalog") && !File.empty?("#{CREW_PREFIX}/etc/xml/catalog")
      puts "#{CREW_PREFIX}/etc/xml/catalog exists" if @opt_verbose
    else
      puts "Creating #{CREW_PREFIX}/etc/xml/catalog" if @opt_verbose
      FileUtils.rm_f "#{CREW_PREFIX}/etc/xml/catalog"
      system "LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} xmlcatalog --noout --create #{CREW_PREFIX}/etc/xml/catalog || true"
    end

    if File.exist?("#{CREW_PREFIX}/etc/xml/docbook-xml") && !File.empty?("#{CREW_PREFIX}/etc/xml/docbook-xml")
      puts "#{CREW_PREFIX}/etc/xml/docbook-xml not empty" if @opt_verbose
    else
      puts "Creating #{CREW_PREFIX}/etc/xml/docbook-xml" if @opt_verbose
      FileUtils.rm_f "#{CREW_PREFIX}/etc/xml/docbook-xml"
      system "xmlcatalog --noout --create #{CREW_PREFIX}/etc/xml/docbook-xml"
    end
    # End Docbook common preinstall block
  end

  def self.postinstall
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
