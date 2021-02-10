require 'package'

class Docbook_xml45 < Package
  description 'A widely used XML scheme for writing documentation and help'
  homepage 'https://www.oasis-open.org/docbook/'
  @_ver = '4.5'
  version "#{@_ver}-1"
  compatibility 'all'
  source_url "https://docbook.org/xml/#{@_ver}/docbook-xml-#{@_ver}.zip"
  source_sha256 '4e4e037a2b83c98c6c94818390d4bdd3f6e10f6ec62dd79188594e26190dc7b4'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xml45-4.5-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xml45-4.5-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xml45-4.5-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xml45-4.5-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'e7463d14aad6712597f6eff575042128392a6783da2c471b36fb61395405cb1b',
     armv7l: 'e7463d14aad6712597f6eff575042128392a6783da2c471b36fb61395405cb1b',
       i686: '168de1189b9d953c7a8e09196af78867dc73f3e16931c6f2bb4f2f8d3c0fc747',
     x86_64: '715699ab3ffddc03de0b8d950c129a6f79b062b82983f9e1e795dc6b9ad5c42c'
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
