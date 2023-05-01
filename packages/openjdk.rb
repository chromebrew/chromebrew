require 'package'
Dir["#{CREW_PACKAGES_PATH}/openjdk*.rb"].each do |openjdkFile|
  next unless openjdkFile =~ /openjdk(\d+).rb/

  openjdkName = File.basename(openjdkFile, '.rb')
  require_relative openjdkName
end

class Openjdk < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://openjdk.org/'
  key = 1
  versions = []
  @openjdkVersions = []
  Dir["#{CREW_PACKAGES_PATH}/openjdk*.rb"].each do |openjdkFile|
    next unless openjdkFile =~ /openjdk(\d+).rb/

    openjdkName = File.basename(openjdkFile, '.rb')
    openjdkVer = Object.const_get(openjdkName.capitalize).version.to_s.gsub(/-(\d+)/, '')
    openjdkMajVer = openjdkVer.match?(/^1.8/) ? '8' : openjdkVer.partition('.')[0]
    @openjdkVersions.push [key, openjdkName, openjdkVer]
    key += 1
  end
  @openjdkVersions.each do |openjdkVer|
    versions.push openjdkVer[2]
  end
  versions.sort!
  version "#{versions.first}-#{versions.last}"
  license 'GPL-2'
  compatibility 'all'

  is_fake

  def self.preflight
    if ARGV.include?('install')
      puts "\n  Select version:"
      @openjdkVersions.each do |openjdkVer|
        option = "  #{openjdkVer[0]} = Openjdk #{openjdkVer[2]}"
        if File.file? "#{CREW_META_PATH}/#{openjdkVer[1]}.filelist"
          puts option.lightgreen
        else
          puts option
        end
      end
      puts '  0 = Cancel'

      while version = $stdin.gets.chomp.downcase.to_i
        version = 0 if version.negative? || version > @openjdkVersions.length
        key = version - 1
        case version
        when @openjdkVersions[key][0]
          if File.file? "#{CREW_META_PATH}/#{@openjdkVersions[key][1]}.filelist"
            abort "Package #{@openjdkVersions[key][1]} already installed.".lightgreen
          else
            depends_on @openjdkVersions[key][1]
          end
          break
        when 0
          abort
        end
      end
    end
  end
end
