require 'json'
require_relative 'color'

class Pip
  def self.get_package_info(pkgName, prefer_online: false)
    is_installed = installed_list.key?(pkgName)

    if prefer_online || !is_installed
      pkgInfo = JSON.parse(`curl -LSs https://pypi.org/pypi/#{pkgName}/json`, symbolize_names: true)

      info = {
        description: pkgInfo[:info][:description],
        homepage: pkgInfo[:info][:home_page],
        license: pkgInfo[:info][:license],
        version: pkgInfo[:info][:version]
      }.transform_values(&:chomp)
    else
      pkgInfo   = `pip show -f #{pkgName}`.scan(/^[[:blank:]]*(.+?): (.+)$/).to_h
      pkgPrefix = pkgInfo['Location']

      filelist = pkgInfo[pkgInfo.index('Files:')..].map do |path|
        File.expand_path(path, pkgPrefix)
      end

      info = {
        description: pkgInfo['Summary'],
        homepage: pkgInfo['Home-page'],
        license: pkgInfo['License'],
        version: pkgInfo['Version'],
        filelist:
      }
    end
  end

  def self.update_installed_list
    @installed = `pip freeze`.scan(/^(.+?)==(.+)$/).to_h
  end

  def self.update_upgradable_list
    @upgradable = `pip list --outdated`.lines(chomp: true)[2..].map do |pkg|
      pkgName, currentVer, latestVer, _ = pkg.split(/\s+/, 4)
      [pkgName, [currentVer, latestVer]]
    end.to_h
  end

  def self.installed_list = (@installed || update_installed_list)
  def self.upgradable_list = (@upgradable_list || update_upgradable_list)

  def self.check_update
    upgradable_list.each_pair do |pkgName, (currentVer, latestVer)|
      puts "#{pkgName} could be updated from #{currentVer} to #{latestVer}"
    end

    return upgradable_list.size
  end

  def self.upgrade(pkgName = nil)
    if pkgName
      install pkgName, '--upgrade'
    else
      upgradable_list.each_pair do |pkgName, (currentVer, latestVer)|
        install "#{pkgName}==#{latestVer}", '--upgrade'
      end
    end
    update_installed_list
    update_upgradable_list
  end

  def self.install(pkgName, version = nil, *opts)
    if installed_list.key?(pkgName)
      warn "Package py3_#{pkgName} already installed, skipping...".lightgreen
      return false
    else
      pkgName = version ? "#{pkgName}==#{version}" : pkgName
      system 'pip', 'install', pkgName, *opts, exception: true
      update_installed_list
    end
  end

  def self.remove(pkgName)
    if installed_list.key?(pkgName)
      system 'pip', 'uninstall', '--yes', pkgName, exception: true
      update_installed_list
    else
      warn "Package py3_#{pkgName} isn't installed.".lightred
      return false
    end
  end

  def self.reinstall(pkgName)
    remove pkgName
    install pkgName
  end

  def self.get_filelist(pkgName)
    abort unless installed_list.key?(pkgName)

    return get_package_info(pkgName)[:filelist]
  end
end