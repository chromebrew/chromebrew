require_relative '../lib/convenience_functions'
require_relative '../lib/package_utils'
require_relative '../lib/package'

class Command
  def self.autoremove(verbose: false, force: false)
    device_json    = ConvenienceFunctions.load_symbolized_json
    redundant_deps = []

    device_json[:installed_packages].each do |pkg|
      # Exclude packages without is_manual_install field
      next unless pkg.key?(:is_manual_install)

      # Exclude manually installed (non-dependency) packages
      next if pkg[:is_manual_install]

      # Add package to redundant list if no other installed package depends on it
      redundant_deps << pkg[:name] if PackageUtils.reverse_dependency_lookup(pkg[:name], installed: true).none?
    end

    if redundant_deps.none?
      puts 'There are no unused dependencies to remove.'.lightgreen
      return
    end

    warn <<~EOT

      The following package(s) will be REMOVED:

      #{redundant_deps.join("\n  ")}

    EOT

    if @opt_force
      puts 'Proceeding with package removal...'.orange
    elsif !Package.agree_default_yes('Proceed')
      abort 'No changes made.'
    end

    redundant_deps.each do |pkg_name|
      pkg = Package.load_package("#{CREW_PACKAGES_PATH}/#{pkg_name}.rb")
      Command.remove(pkg, verbose:, force:)
    end
  end
end
