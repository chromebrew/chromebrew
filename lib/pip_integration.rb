require 'json'
require_relative 'color'

class Pip
  def self.get_package_info(pkgName, prefer_online: false)
    is_installed = installed_list.key?(pkgName)

    if prefer_online || !is_installed
      pkgInfo = JSON.parse(`curl -LSs https://pypi.org/pypi/#{pkgName}/json`, symbolize_names: true)
    else
      pkgInfo = pip_inspect[:installed].select {|pkg| pkg[:metadata][:name] == pkgName } [:metadata]
    end

    info = {
      description: pkgInfo[:info][:description],
      homepage: pkgInfo[:info][:home_page],
      license: pkgInfo[:info][:license],
      version: pkgInfo[:info][:version]
    }.transform_values(&:chomp)
  end

  def self.update_cache
    @inspect   = JSON.parse(`pip inspect 2> /dev/null`, symbolize_names: true)
    @installed = @inspect[:installed].map {|pkg| pkg[:metadata][:name] }
  end

  def self.update_upgradable_list
    @upgradable = `pip list --outdated`.lines(chomp: true)[2..].map do |pkg|
      pkgName, currentVer, latestVer, _ = pkg.split(/\s+/, 4)
      [pkgName, [currentVer, latestVer]]
    end.to_h
  end

  def self.pip_inspect         = (@inspect || update_cache)
  def self.installed_list      = (@installed || update_cache)
  def self.upgradable_list     = (@upgradable_list || update_upgradable_list)
  def self.installed?(pkgName) = installed_list.key?(pkgName)

  def self.check_update
    upgradable_list.each_pair do |pkgName, (currentVer, latestVer)|
      puts "#{pkgName} could be updated from #{currentVer} to #{latestVer}"
    end

    return upgradable_list.size
  end

  def self.upgrade(pkgName = nil)
    if pkgName
      install pkgName, '--upgrade', run_anyways: true
    else
      upgradable_list.each_pair do |pkgName, (currentVer, latestVer)|
        install "#{pkgName}==#{latestVer}", '--upgrade', run_anyways: true
      end
    end
    update_cache
    update_upgradable_list
  end

  def self.install(pkgName, version = nil, *opts, run_anyways: true)
    if installed_list.key?(pkgName) && !run_anyways
      warn "Package py3_#{pkgName} already installed, skipping...".lightgreen
      return false
    else
      pkgName = version ? "#{pkgName}==#{version}" : pkgName
      system 'pip', 'install', pkgName, *opts, exception: true
      update_cache
    end
  end

  def self.remove(pkgName)
    if installed_list.key?(pkgName)
      system 'pip', 'uninstall', '--yes', pkgName, exception: true
      update_cache
    else
      warn "Package py3_#{pkgName} isn't installed.".lightred
      return false
    end
  end

  def self.get_filelist(pkgName)
    abort "Package #{pkgName} is not installed. :(".lightred unless installed_list.key?(pkgName)

    pipOutput   = `pip show -f #{pkgName}`
    pkgInfo     = pipOutput.scan(/^[[:blank:]]*(.+?): (.+)$/).to_h
    pkgPrefix   = pkgInfo['Location']
    filelist    = pipOutput.partition('Files:').last.lines.map {|path| File.expand_path(path.strip, pkgPrefix) }

    return filelist
  end
end