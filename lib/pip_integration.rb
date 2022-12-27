require 'json'
require_relative 'color'

class Pip
  def self.get_package_info(pkgName, prefer_online: false)
    is_installed = installed?(pkgName)

    if prefer_online || !is_installed
      pkgInfo = JSON.parse(`curl -LSs https://pypi.org/pypi/#{pkgName}/json`, symbolize_names: true)[:info]
    else
      pkgInfo = pip_inspect[:installed].select {|pkg| pkg[:metadata][:name] == pkgName } [0][:metadata]
    end

    info = {
      # use "summary" if "description" is too long
      description: (pkgInfo[:description] && pkgInfo[:description].count("\n") >= 3) ? pkgInfo[:summary] : pkgInfo[:description] || '',
      homepage: pkgInfo[:home_page],
      license: pkgInfo[:license],
      version: pkgInfo[:version]
    }.transform_values(&:chomp)
  end

  def self.update_cache
    @inspect = JSON.parse(`pip inspect 2> /dev/null`, symbolize_names: true)
  end

  def self.update_upgradable_list
    @upgradable = `pip list --outdated`.lines(chomp: true)[2..].map do |pkg|
      pkgName, currentVer, latestVer, _ = pkg.split(/\s+/, 4)
      [pkgName, [currentVer, latestVer]]
    end.reject do |(pkgName, _)|
      # don't check for updates if crew version exists
      File.file?( File.join(CREW_PACKAGES_PATH, "py3_#{pkgName.tr('-', '_').downcase}.rb") )
    end.to_h
  end

  def self.pip_inspect         = (@inspect || update_cache)
  def self.upgradable_list     = (@upgradable_list || update_upgradable_list)
  def self.installed?(pkgName) = pip_inspect[:installed].any? {|pkg| pkg[:metadata][:name] == pkgName }

  def self.check_update
    upgradable_list.each_pair do |pkgName, (currentVer, latestVer)|
      puts "py3_#{pkgName.tr('-', '_').downcase} could be updated from #{currentVer} to #{latestVer}"
    end

    return upgradable_list.size
  end

  def self.upgrade(pkgName = nil)
    if pkgName
      install pkgName, '--upgrade', reinstall: true
    else
      upgradable_list.each_pair do |pkgName, (currentVer, latestVer)|
        install pkgName, '--upgrade', version: latestVer, reinstall: true
      end
    end
    update_cache
    update_upgradable_list
  end

  def self.install(pkgName, *opts, version: nil, reinstall: true)
    if installed?(pkgName) && !reinstall
      warn "Package py3_#{pkgName} already installed, skipping...".lightgreen
      return false
    elsif reinstall
      remove(pkgName)
    end

    pkgName = "#{pkgName}==#{version}" if version
    system 'pip', 'install', pkgName, *opts, exception: true

    update_cache
  end

  def self.remove(pkgName)
    if installed?(pkgName)
      system 'pip', 'uninstall', '--yes', pkgName, exception: true
      update_cache
    else
      warn "Package py3_#{pkgName} isn't installed.".lightred
      return false
    end
  end

  def self.get_filelist(pkgName)
    abort "Package #{pkgName} is not installed. :(".lightred unless installed?(pkgName)

    pipOutput   = `pip show -f #{pkgName}`
    pkgInfo     = pipOutput.scan(/^[[:blank:]]*(.+?): (.+)$/).to_h
    pkgPrefix   = pkgInfo['Location']
    filelist    = pipOutput.partition('Files:').last.lines.map {|path| File.expand_path(path.strip, pkgPrefix) }

    return filelist
  end
end