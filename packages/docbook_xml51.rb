require 'package'

class Docbook_xml51 < Package
  description 'A widely used XML scheme for writing documentation and help'
  homepage 'https://www.oasis-open.org/docbook/'
  @_ver = '5.1'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url "https://docbook.org/xml/#{@_ver}/docbook-v#{@_ver}-os.zip"
  source_sha256 'b3f3413654003c1e773360d7fc60ebb8abd0e8c9af8e7d6c4b55f124f34d1e7f'

  depends_on 'docbook_xml'
  depends_on 'libxml2'
  depends_on 'xmlcatmgr'
  depends_on 'bash'

  def self.install
    system "xmlcatalog --noout --create docbook-#{@_ver}.xml"
    # RNG
    system "xmlcatalog --noout --add 'uri' \
      'http://www.oasis-open.org/docbook/xml/#{@_ver}/rng/docbook.rng' \
      'file://#{CREW_PREFIX}/share/xml/docbook/schema/rng/#{@_ver}/docbook.rng' docbook-#{@_ver}.xml"
    system "xmlcatalog --noout --add 'uri' \
      'http://docbook.org/xml/#{@_ver}/rng/docbook.rng' \
      'file://#{CREW_PREFIX}/share/xml/docbook/schema/rng/#{@_ver}/docbook.rng' docbook-#{@_ver}.xml"
    # RNG+XInclude
    system "xmlcatalog --noout --add 'uri' \
      'http://www.oasis-open.org/docbook/xml/#{@_ver}/rng/docbookxi.rng' \
      'file://#{CREW_PREFIX}/share/xml/docbook/schema/rng/#{@_ver}/docbookxi.rng' docbook-#{@_ver}.xml"
    system "xmlcatalog --noout --add 'uri' \
      'http://docbook.org/xml/#{@_ver}/rng/docbookxi.rng' \
      'file://#{CREW_PREFIX}/share/xml/docbook/schema/rng/#{@_ver}/docbookxi.rng' docbook-#{@_ver}.xml"
    # RNC
    system "xmlcatalog --noout --add 'uri' \
      'http://www.oasis-open.org/docbook/xml/#{@_ver}/rnc/docbook.rnc' \
      'file://#{CREW_PREFIX}/share/xml/docbook/schema/rng/#{@_ver}/docbook.rnc' docbook-#{@_ver}.xml"
    system "xmlcatalog --noout --add 'uri' \
      'http://docbook.org/xml/#{@_ver}/rng/docbook.rnc' \
      'file://#{CREW_PREFIX}/share/xml/docbook/schema/rng/#{@_ver}/docbook.rnc' docbook-#{@_ver}.xml"
    # RNC+XInclude
    system "xmlcatalog --noout --add 'uri' \
      'http://www.oasis-open.org/docbook/xml/#{@_ver}/rnc/docbookxi.rnc' \
      'file://#{CREW_PREFIX}/share/xml/docbook/schema/rng/#{@_ver}/docbookxi.rnc' docbook-#{@_ver}.xml"
    system "xmlcatalog --noout --add 'uri' \
      'http://docbook.org/xml/#{@_ver}/rng/docbookxi.rnc' \
      'file://#{CREW_PREFIX}/share/xml/docbook/schema/rng/#{@_ver}/docbookxi.rnc' docbook-#{@_ver}.xml"
    # Schematron
    system "xmlcatalog --noout --add 'uri' \
      'http://www.oasis-open.org/docbook/xml/#{@_ver}/sch/docbook.sch' \
      'file://#{CREW_PREFIX}/share/xml/docbook/schema/sch/#{@_ver}/docbook.sch' docbook-#{@_ver}.xml"
    system "xmlcatalog --noout --add 'uri' \
      'http://docbook.org/xml/#{@_ver}/sch/docbook.sch' \
      'file://#{CREW_PREFIX}/share/xml/docbook/schema/sch/#{@_ver}/docbook.sch' docbook-#{@_ver}.xml"
    # Build XML catalog files for each Schema
    @ADDFILES_SH = <<~ADDFILES_HEREDOC
      for s in schemas/rng schemas/sch; do
        _schema_catalog=${s}/catalog.xml
        xmlcatalog --noout --create ${_schema_catalog}
        case $s in
          sch)
            xmlcatalog --noout --add 'uri' \
              'http://docbook.org/xml/#{@_ver}/${s}/docbook.${s}' \
              'docbook.${s}' ${_schema_catalog}
            xmlcatalog --noout --add 'uri' \
              'http://www.oasis-open.org/docbook/xml/#{@_ver}/${s}/docbook.${s}' \
              'docbook.${s}' ${_schema_catalog}
            ;;
          rng)
            xmlcatalog --noout --add 'uri' \
              'http://docbook.org/xml/#{@_ver}/${s}/docbook.${s}' \
              'docbook.${s}' ${_schema_catalog}
            xmlcatalog --noout --add 'uri' \
              'http://www.oasis-open.org/docbook/xml/#{@_ver}/${s}/docbook.${s}' \
              'docbook.${s}' ${_schema_catalog}
            xmlcatalog --noout --add 'uri' \
              'http://docbook.org/xml/#{@_ver}/${s}/docbookxi.${s}' \
              'docbookxi.${s}' ${_schema_catalog}
            xmlcatalog --noout --add 'uri' \
              'http://www.oasis-open.org/docbook/xml/#{@_ver}/${s}/docbookxi.${s}' \
              'docbookxi.${s}' ${_schema_catalog}
            xmlcatalog --noout --add 'uri' \
              'http://docbook.org/xml/#{@_ver}/${s}/docbook.rnc' \
              'docbook.rnc' ${_schema_catalog}
            xmlcatalog --noout --add 'uri' \
              'http://www.oasis-open.org/docbook/xml/#{@_ver}/${s}/docbook.rnc' \
              'docbook.rnc' ${_schema_catalog}
            xmlcatalog --noout --add 'uri' \
              'http://docbook.org/xml/#{@_ver}/${s}/docbookxi.rnc' \
              'docbookxi.rnc' ${_schema_catalog}
            xmlcatalog --noout --add 'uri' \
              'http://www.oasis-open.org/docbook/xml/#{@_ver}/${s}/docbookxi.rnc' \
              'docbookxi.rnc' ${_schema_catalog}
            ;;
        esac
      done
    ADDFILES_HEREDOC
    IO.write('add_files.sh', @ADDFILES_SH, perm: 0o755)
    system "#{CREW_PREFIX}/bin/bash -x ./add_files.sh | true"

    system "#{CREW_PREFIX}/bin/bash -c \"for type in rng sch ; do
      mkdir -p #{CREW_DEST_PREFIX}/share/xml/docbook/schema/\\\${type}/#{@_ver}
      install -m644 schemas/\\\${type}/* #{CREW_DEST_PREFIX}/share/xml/docbook/schema/\\\${type}/#{@_ver}
    done\""
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    system "install -m755 tools/db4-entities.pl #{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/xml/docbook/stylesheet/docbook5"
    system "install -m644 tools/db4-upgrade.xsl #{CREW_DEST_PREFIX}/share/xml/docbook/stylesheet/docbook5/"

    # catalog configuration
    system "mkdir -p #{CREW_DEST_PREFIX}/etc/xml"
    system "install -m644 docbook-#{@_ver}.xml  #{CREW_DEST_PREFIX}/etc/xml/docbook-#{@_ver}.xml"
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
