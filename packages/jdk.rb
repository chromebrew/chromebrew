require 'package'

class Jdk < Package
  description 'The Oracle JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://www.oracle.com/java'
  version 'LATEST'
  license 'Oracle-BCLA-JavaSE'
  compatibility 'all'

  is_fake

  def self.preflight
    if ARGV.include?('install')
      if File.exist?("#{CREW_PREFIX}/bin/java")
        jdkver_str = `#{CREW_PREFIX}/bin/java -version 2>&1`
        is_openjdk = jdkver_str.include?('openjdk')
        jdkver     = jdkver_str[/version "(.+?)"/, 1]
        majver     = jdkver.split('.')[0]
        majver     = '8' if majver == '1'
        pkg_suffix = (is_openjdk) ? 'openjdk' : 'jdk'

        puts "Package #{pkg_suffix}#{majver} already installed.".lightgreen
        warn "Run `crew remove #{pkg_suffix}#{majver} && crew install jdk` to install a different version.".yellow
        return false
      end

      jdk_latest_ver = %w[8 11 17 18].map do |jdk_majver|
        pkg = Package.load_package("#{CREW_PACKAGES_PATH}/jdk#{jdk_majver}.rb")

        [jdk_majver, pkg.version]
      end.to_h

      options = [
        { value: 'jdk8' , description: "Oracle JDK 8"  },
        { value: 'jdk11', description: "Oracle JDK 11" }, 
        { value: 'jdk17', description: "Oracle JDK 17" },
        { value: 'jdk18', description: "Oracle JDK 18" }
      ]

      depends_on Selector.new(options).show_prompt
    end
  end
end
