require_relative '../lib/const'
require_relative '../lib/package'
require_relative '../lib/package_utils'

class Command
  def self.whatprovides(regex)
    matched_list = `grep -ER "#{regex}" #{CREW_LIB_PATH}/manifest/#{ARCH}`.lines(chomp: true).flat_map do |result|
      filelist, matched_file = result.split(':', 2)
      pkg_name = File.basename(filelist, '.filelist')
      pkg_name_status = File.file?(File.join(CREW_PACKAGES_PATH, "#{pkg_name}.rb")) ? pkg_name : nil
      if pkg_name_status
        if PackageUtils.compatible?(Package.load_package(File.join(CREW_PACKAGES_PATH, "#{pkg_name}.rb")))
          pkg_name_status = pkg_name.lightgreen if PackageUtils.installed?(pkg_name)
        else
          pkg_name_status = pkg_name.lightred
        end
      end

      pkg_name_status.nil? ? '' : "#{pkg_name_status}: #{matched_file}"
    end.sort.map(&:strip).reject(&:empty?)

    puts matched_list, "\nTotal found: #{matched_list.length}".lightgreen if matched_list.any?
  end
end
