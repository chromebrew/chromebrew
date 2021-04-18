require 'package'

class Docbook_xml44 < Package
  description 'A widely used XML scheme for writing documentation and help'
  homepage 'https://www.oasis-open.org/docbook/'
  @_ver = '4.4'
  version "#{@_ver}-2"
  license 'MIT'
  compatibility 'all'
  source_url "https://docbook.org/xml/#{@_ver}/docbook-xml-#{@_ver}.zip"
  source_sha256 '02f159eb88c4254d95e831c51c144b1863b216d909b5ff45743a1ce6f5273090'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/docbook_xml44-4.4-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/docbook_xml44-4.4-2-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/docbook_xml44-4.4-2-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/docbook_xml44-4.4-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '0a46c480b0091976c7f205f357e40a89dd8184b6e8917f83b650b61a4d19842f',
     armv7l: '0a46c480b0091976c7f205f357e40a89dd8184b6e8917f83b650b61a4d19842f',
       i686: '245084bbab863f35e180a73c0b673ded95f7e62de840f232ac9c367888dabd78',
     x86_64: 'a0d55ff8144b07bafcf720618dacaa60ccd520fa2b3fb952069cfc93fbf87abb'
  })

  depends_on 'docbook_xml'
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
    system "xmlcatalog --noout --add 'public' \
      '-//OASIS//ELEMENTS DocBook XML HTML Tables V#{@_ver}//EN' \
      'http://www.oasis-open.org/docbook/xml/#{@_ver}/htmltblx.mod' \
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
